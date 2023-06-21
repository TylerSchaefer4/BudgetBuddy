//
//  ShowProfileController.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit
import FirebaseAuth

class ShowProfileController: UIViewController {
    
    let showProfile = ShowProfileView()
    
    var currentUser:FirebaseAuth.User!
    
    override func loadView() {
        view = showProfile
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(onEditButtonTapped))
    }
    
    @objc func onEditButtonTapped() {
        
    }
}
