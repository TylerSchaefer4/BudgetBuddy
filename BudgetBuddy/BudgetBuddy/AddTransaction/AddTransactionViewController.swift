//
//  AddTransactionViewController.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit
import Firebase
import FirebaseAuth
import PhotosUI
import FirebaseStorage



class AddTransactionViewController: UIViewController {

    var addTransactionView = AddTransactionView()
    var currentUser:FirebaseAuth.User!
    var selectedType = "Expense"
    let storage = Storage.storage()

    var pickedImage:UIImage?

    
    
    override func loadView() {
        view = addTransactionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTransactionView.pickerTransactionType.delegate = self
        addTransactionView.pickerTransactionType.dataSource = self
        title = "Add Transaction"
        
        addTransactionView.ReceiptPhoto.menu = getMenuImagePicker()

        
        self.addTransactionView.addButton.addTarget(self, action: #selector(onAddButtonTapped), for: .touchUpInside)
        //self.getUserInformation()
    }
    
    func getMenuImagePicker() -> UIMenu{
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    //MARK: take Photo using Camera...
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
        //MARK: Photo from Gallery...
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    @objc func onAddButtonTapped() {
        guard let amountString = addTransactionView.textFieldAmount.text,
              let amount = Int(amountString),
              amount > 0 else {
            print("Invalid amount")
            return
        }

        let type = addTransactionView.selectedPhoneNumberType
        let nameOfPlace = addTransactionView.textFieldNameOfPlace.text ?? ""
        let description = addTransactionView.textFieldDescription.text ?? ""
        let location = addTransactionView.textFieldLocation.text ?? ""
        let timestamp = Date()  // Current date and time
        

        guard let user = Auth.auth().currentUser else {
            print("No user is signed in.")
            return
        }


        // check if image was picked
        if let image = pickedImage {
            // Upload to Firebase Storage
            uploadImageToFirebase(user: user, image: image) { [weak self] (imageUrl) in
                guard let self = self else { return }
                
                if let imageUrl = imageUrl {
                    // Create the Transaction object and save to Firestore
                    let transaction = Transaction(type: type, amount: amount, nameOfPlace: nameOfPlace, description: description, location: location, timeStamp: timestamp, imageUrl: imageUrl)
                    self.saveTransactionToFirebase(user: user, transaction: transaction)
                } else {
                    print("Error uploading image to Firebase Storage.")
                }
            }
        } else {
            // Create the Transaction object without an image and save to Firestore
            let transaction = Transaction(type: type, amount: amount, nameOfPlace: nameOfPlace, description: description, location: location, timeStamp: timestamp, imageUrl: "")
            saveTransactionToFirebase(user: user, transaction: transaction)
        }
    }

    func saveTransactionToFirebase(user: FirebaseAuth.User, transaction: Transaction) {
        let db = Firestore.firestore()
        
        let userEmail = user.email ?? ""
        let transactionRef = db.collection("users").document(userEmail).collection("transactions").document()
        
        do {
            try transactionRef.setData(from: transaction)
            self.navigationController?.popViewController(animated: true)
        } catch let error {
            print("Error writing transaction to Firestore: \(error)")
        }
    }

    func uploadImageToFirebase(user: FirebaseAuth.User, image: UIImage, completion: @escaping (_ imageUrl: String?) -> Void) {
        guard let data = image.jpegData(compressionQuality: 0.4) else {
            completion(nil)
            return
        }
        
        let imageName = UUID().uuidString
        let imageRef = storage.reference().child("transaction_images/\(user.uid)/\(imageName).jpg")
        
        imageRef.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error uploading image to Firebase Storage: \(error)")
                completion(nil)
            } else {
                imageRef.downloadURL { (url, error) in
                    if let error = error {
                        print("Error getting download URL: \(error)")
                        completion(nil)
                    } else {
                        completion(url?.absoluteString)
                    }
                }
            }
        }
    }

}


extension AddTransactionViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //MARK: we are using only one section...
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //MARK: we are displaying the options from Utilities.types...
        return Utilities.types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //MARK: updating the selected type when the user picks this row...
        selectedType = Utilities.types[row]
        return Utilities.types[row]
    }
}


//MARK: adopting required protocols for PHPicker...
extension AddTransactionViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(
                    ofClass: UIImage.self,
                    completionHandler: { (image, error) in
                        DispatchQueue.main.async{
                            if let uwImage = image as? UIImage{
                                self.addTransactionView.ReceiptPhoto.setImage(
                                    uwImage.withRenderingMode(.alwaysOriginal),
                                    for: .normal
                                )
                                self.pickedImage = uwImage
                            }
                        }
                    }
                )
            }
        }
    }
}

//MARK: adopting required protocols for UIImagePicker...
extension AddTransactionViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.addTransactionView.ReceiptPhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}

