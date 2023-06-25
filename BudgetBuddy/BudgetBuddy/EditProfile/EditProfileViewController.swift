//
//  EditProfileViewController.swift
//  BudgetBuddy
//
//  Created by Muneer Lalji on 6/21/23.
//

import UIKit
import PhotosUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class EditProfileViewController: UIViewController {
    
    let editProfileScreen = EditProfileView()
    
    var currentUser:FirebaseAuth.User!
    
    var profileImage:UIImage?
    
    let storage = Storage.storage()
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = editProfileScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Profile"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onSaveButtonTapped))
        
        editProfileScreen.buttonTakePhoto.menu = getMenuImagePicker()
    }
    
    @objc func onSaveButtonTapped() {
        if let name = editProfileScreen.nameTextField.text, let username = editProfileScreen.usernameTextField.text, let email = editProfileScreen.emailTextField.text {
            if self.profileImage != nil {
                self.uploadToStorage(name: name, email: email, image: self.profileImage)
            }
        }
        else {
            print("error")
            showErrorAlert("No fields should be empty")
        }
    }
    
    func uploadToStorage(name:String, email: String, image: UIImage?) {
        var profilePhotoURL:URL?
                
                //MARK: Upload the profile photo if there is any...
        if let picture = image{
            if let jpegData = picture.jpegData(compressionQuality: 80){
                let storageRef = storage.reference()
                let imagesRepo = storageRef.child("imagesUsers")
                let imageRef = imagesRepo.child("\(NSUUID().uuidString).jpg")
                        
                let uploadTask = imageRef.putData(jpegData, completion: {(metadata, error) in
                    if error == nil{
                        imageRef.downloadURL(completion: {(url, error) in
                            if error == nil{
                                profilePhotoURL = url
                                self.modifyFirebaseProfile(name: name, email: email, photoURL: profilePhotoURL)
                            }
                        })
                    }
                })
            }
        }else{
            modifyFirebaseProfile(name: name, email: email, photoURL: profilePhotoURL)
        }
    }
    
    func modifyFirebaseProfile(name: String, email: String, photoURL: URL?){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.photoURL = photoURL
    
        print("\(photoURL)")
        changeRequest?.commitChanges(completion: {(error) in
            if error != nil{
                print("Error occured: \(String(describing: error))")
                showErrorAlert("error")
            }else{
                Auth.auth().currentUser?.updateEmail(to: email) {error in
                    if let error = error {
                        print("failed to update email")
                        showErrorAlert("Failed to update email")
                    } else {
                        self.updateFirestore(name: name, email: email, photoURL: photoURL)
                    }
                }
            }
        })
    }
    
    func updateFirestore(name: String, email: String, photoURL: URL?) {
        database.collection("users").document(email).setData([
            "name": name,
            "email": email,
            "photoURL": photoURL
        ], completion: {(error) in
            if error == nil {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    func getMenuImagePicker() -> UIMenu{
        var menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    func pickUsingCamera() {
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    func pickPhotoFromGallery() {
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
                
        let photoPicker = PHPickerViewController(configuration: configuration)
                
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }

}

extension EditProfileViewController:PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.editProfileScreen.buttonTakePhoto.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.profileImage = uwImage
                        }
                    }
                })
            }
        }
    }
}

extension EditProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.editProfileScreen.buttonTakePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.profileImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}
