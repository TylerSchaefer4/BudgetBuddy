//
//  AddFriendController.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

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
                self.showErrorAlert("Incorrect email")
                return
            }
            
            do {
                let documentData = document.data()
                let jsonData = try JSONSerialization.data(withJSONObject: documentData, options: [])
                let decoder = JSONDecoder()
                let friend = try decoder.decode(Friend.self, from: jsonData)
                self.addFriendToCollection(friend: friend)
            }
            catch {
                print("error decoding document")
            }
        }
    }
    
    func addFriendToCollection(friend: Friend) {
        database.collection("users").document(self.currentUser.email!).collection("friends").getDocuments { (querySnapshot, error) in
            if let error = error {
                    print("Error getting documents: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    self.database.collection("users").document(self.currentUser.email!).collection("friends").addDocument(
                        data: ["name": friend.name,
                               "email": friend.email,
                               "photoURL": friend.photoURL],
                        completion: {(error) in
                            if let error = error {
                                print("Error adding document")
                            }
                            else {
                                self.navigationController?.popViewController(animated: true)
                            }
                        })
                    return
                }
                    
                for document in documents {
                    do {
                        let documentData = document.data()
                        let jsonData = try JSONSerialization.data(withJSONObject: documentData, options: [])
                        let decoder = JSONDecoder()
                        let person = try decoder.decode(Friend.self, from: jsonData)
                        if person.email == friend.email {
                            self.showErrorAlert("You already have \(friend.name) as a friend")
                            return
                        }
                        print(person)
                    } catch {
                        print("Error decoding document: \(error)")
                    }
                }
                self.database.collection("users").document(self.currentUser.email!).collection("friends").addDocument(
                    data: ["name": friend.name,
                           "email": friend.email,
                           "photoURL": friend.photoURL],
                completion: {(error) in
                    if let error = error {
                        print("Error adding document")
                    }
                })
                let current = Friend(name: self.currentUser.displayName!, email: self.currentUser.email!, photoURL: self.currentUser.photoURL?.absoluteString)
                self.database.collection("users").document(friend.email).collection("friends").addDocument(
                    data: ["name": friend.name,
                           "email": friend.email,
                           "photoURL": friend.photoURL],
                completion: {(error) in
                    if let error = error {
                        print("Error adding document")
                    }
                    else {
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }
    }
    
}
