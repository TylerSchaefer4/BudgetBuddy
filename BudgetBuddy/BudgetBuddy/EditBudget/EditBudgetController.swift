//
//  EditBudgetController.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit
import Firebase
import FirebaseAuth
import PhotosUI
import FirebaseStorage


class EditBudgetController: UIViewController {

    var editBudgetView = EditBudgetView()
    var currentUser:FirebaseAuth.User!
    
    let database = Firestore.firestore()

    override func loadView() {
        view = editBudgetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Budget"
        self.currentUser = Auth.auth().currentUser
        
        fetchUserBudgetData()
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }

    func fetchUserBudgetData() {
        database.collection("users")
            .whereField("email", isEqualTo: self.currentUser?.email)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error querying documents: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No matching documents found")
                    return
                }
                
                for document in documents {
                    let user = document.data()
                    if let budget = user["budget"] as? Int,
                       let spent = user["spent"] as? Int,
                       let expectedExpenses = user["expectedExpenses"] as? Int {
                        self.editBudgetView.textFieldThisWeeksBudget.text = String(budget)
                        self.editBudgetView.textFieldTotalAmountSpent.text = String(spent)
                        self.editBudgetView.textFieldExpectedExpenses.text = String(expectedExpenses)
                    }
                }
            }
    }
    
    @objc func saveButtonTapped() {
        guard let budgetText = editBudgetView.textFieldThisWeeksBudget.text,
              let spentText = editBudgetView.textFieldTotalAmountSpent.text,
              let expectedExpensesText = editBudgetView.textFieldExpectedExpenses.text,
              let budget = Int(budgetText),
              let spent = Int(spentText),
              let expectedExpenses = Int(expectedExpensesText) else {
            print("Invalid input")
            return
        }

        let userDocument = database.collection("users").document(currentUser.email!)
        userDocument.updateData([
            "budget": budget,
            "spent": spent,
            "expectedExpenses": expectedExpenses
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
