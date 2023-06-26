//
//  AddTransactionViewController.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit
import Firebase
import FirebaseAuth

class AddTransactionViewController: UIViewController {

    var addTransactionView = AddTransactionView()
    var currentUser:FirebaseAuth.User!
    var selectedType = "Expense"

    
    
    override func loadView() {
        view = addTransactionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addTransactionView.pickerTransactionType.delegate = self
        addTransactionView.pickerTransactionType.dataSource = self
        title = "Add Transaction"
        
        self.addTransactionView.addButton.addTarget(self, action: #selector(onAddButtonTapped), for: .touchUpInside)
        //self.getUserInformation()
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
        let imageUrl = "" // Add logic for image url
        
        let transaction = Transaction(type: type, amount: amount, nameOfPlace: nameOfPlace, description: description, location: location, timeStamp: timestamp, imageUrl: imageUrl)

        saveTransactionToFirebase(transaction)
    }

    func saveTransactionToFirebase(_ transaction: Transaction) {
        guard let user = Auth.auth().currentUser else {
            print("No user is signed in.")
            return
        }
        
        let db = Firestore.firestore()
        let transactionRef = db.collection("users").document(user.uid).collection("transactions").document()
        
        do {
            try transactionRef.setData(from: transaction)
        } catch let error {
            print("Error writing transaction to Firestore: \(error)")
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
