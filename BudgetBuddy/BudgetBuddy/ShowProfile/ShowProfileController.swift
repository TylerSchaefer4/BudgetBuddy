//
//  ShowProfileController.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ShowProfileController: UIViewController {
    
    let showProfile = ShowProfileView()
    
    var currentUser:FirebaseAuth.User!
    
    override func loadView() {
        view = showProfile
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(onEditButtonTapped))
        self.currentUser = Auth.auth().currentUser
        self.getUserInformation()
    }
    
    func getUserInformation() {
        self.showProfile.labelEmail.text = self.currentUser.email
        self.showProfile.labelName.text = self.currentUser.displayName
        
//        if let url = self.currentUser.photoURL {
//            self.showProfile.profilePic.loadRemoteImage(from: url)
//        }
    }
    
    @objc func onEditButtonTapped() {
        let editScreen = EditProfileViewController()
        editScreen.currentUser = self.currentUser
        navigationController?.pushViewController(editScreen, animated: true)
    }
}
