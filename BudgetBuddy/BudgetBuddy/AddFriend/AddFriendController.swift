//
//  AddFriendController.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddFriendController: UIViewController {
    
    let addFriendView = AddFriendView()
    
    var currentUser:FirebaseAuth.User!
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = addFriendView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addFriendView.addFriendButton.addTarget(self, action: #selector(onAddFriendButtonTapped), for: .touchUpInside)
    }
    
    @objc func onAddFriendButtonTapped() {
        if let email = addFriendView.emailTextField.text {
            self.addFriend(email: email)
        }
        else {
            print("error unwrapping email")
        }
    }
    
    func addFriend(email: String) {
        database.collection("users").document(email).getDocument { (document, error) in
            if let error = error {
                print("error retrieving document")
                return
            }
            
            guard let document = document, document.exists else {
                print("document doesn't exist")
                showErrorAlert("Incorrect email")
                return
            }
            
            do {
                let friend = document.data(as: Friend.self)
                
                if let friend = friend {
                    self.addFriendToCollection(friend: friend)
                }
            }
            catch {
                print("error decoding document")
            }
        }
    }
    
    func addFriendToCollection(friend: Friend) {
        database.collection("users").document(self.currentUser.email).collection("friends").getDocument { (document, error) in
            if let error = error {
                print("error retrieving document")
            }
            
            if document.exists {
                print("friend is already added")
                self.showErrorAlert("\(friend.name) is already your friend")
            }
            else {
                database.collection("users").document(self.currentUser.email).collection("friends").addDocument(data: [
                    "name" : friend.name,
                    "email": friend.email
                    "photoURL": friend.photoURL
                ], completion: {(error) in
                    if error = nil {
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }
    }
    
}
