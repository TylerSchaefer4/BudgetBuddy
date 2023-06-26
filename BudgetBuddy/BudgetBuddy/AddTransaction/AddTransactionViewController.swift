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
    
    @objc func onAddButtonTapped(){
        
    }

}
