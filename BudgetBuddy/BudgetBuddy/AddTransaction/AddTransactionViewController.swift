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
    
    
    override func loadView() {
        view = addTransactionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Transaction"
        
        self.addTransactionView.addButton.addTarget(self, action: #selector(onAddButtonTapped), for: .touchUpInside)
        //self.getUserInformation()
    }
    
    @objc func onAddButtonTapped() {
        guard let amountString = addTransactionView.textFieldAmount.text,
              let amount = Double(amountString),
              amount > 0 else {
            showErrorAlert("Invalid amount")
            return
        }

        let type = addTransactionView.selectedPhoneNumberType
        let nameOfPlace = addTransactionView.textFieldNameOfPlace.text ?? ""
        let description = addTransactionView.textFieldDescription.text ?? ""
        let location = addTransactionView.textFieldLocation.text ?? ""
        let timestamp = Timestamp(date: Date())
        
        let transaction = Transaction(type: type, amount: amount, nameOfPlace: nameOfPlace, description: description, location: location, timestamp: timestamp)

        saveTransactionToFirebase(transaction)
    }

    func saveTransactionToFirebase(_ transaction: Transaction) {
        guard let user = Auth.auth().currentUser else {
            showErrorAlert("No user is signed in.")
            return
        }
        
        let db = Firestore.firestore()
        let transactionRef = db.collection("users").document(user.uid).collection("transactions").document()
        
        do {
            try transactionRef.setData(from: transaction)
        } catch let error {
            showErrorAlert("Error writing transaction to Firestore: \(error)")
        }
    }


}
