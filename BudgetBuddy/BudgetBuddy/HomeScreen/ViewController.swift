//
//  ViewController.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    let homeScreen = HomeScreenView()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    
    var transactions = [Transaction]()
    var leaderboard = [Contact]()
    
    override func loadView() {
        view = homeScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
                self.title = "Sign In"
                
                //MARK: Reset tableViews...
                self.transactions.removeAll()
                self.leaderboard.removeAll()
                self.homeScreen.tableViewBudgetLeaderBoard.reloadData()
                self.homeScreen.tableViewRecentTransactions.reloadData()
                
                //MARK: Sign in bar button...
                self.setupRightBarButton(isLoggedin: false)
            }
            else {
                //MARK: the user is signed in...
                self.currentUser = user
                self.title = "Welcome \(user?.displayName ?? "Anonymous")!"
                
                //MARK: Logout bar button...
                self.setupRightBarButton(isLoggedin: true)
                
                //MARK: Observe Firestore database to display the contacts/transactions list...
                self.database.collection("users")
                    .document((self.currentUser?.email)!)
                    .collection("transactions")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents, !documents.isEmpty{
                            self.transactions.removeAll()
                            for document in documents{
                                do{
                                    let transaction  = try document.data(as: Transaction.self)
                                    self.transactions.append(transaction)
                                }catch{
                                    print(error)
                                }
                            }
                            self.homeScreen.tableViewRecentTransactions.reloadData()
                        }
                    })
                self.database.collection("users")
                    .document((self.currentUser?.email)!)
                    .collection("friends")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents, !documents.isEmpty{
                            self.leaderboard.removeAll()
                            for document in documents{
                                do{
                                    let contact  = try document.data(as: Contact.self)
                                    self.leaderboard.append(contact)
                                }catch{
                                    print(error)
                                }
                            }
                            self.leaderboard.sort(by: {$0.name < $1.name})
                            self.homeScreen.tableViewRecentTransactions.reloadData()
                        }
                    })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Financial Summary"
        
        let profileButton = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(onProfileButtonTapped))
        
        navigationItem.rightBarButtonItem = profileButton
        
        setupRightBarButton(isLoggedin: false)
        
    }
    
    @objc func onProfileButtonTapped() {
        let showProfileController = ShowProfileController()
        //showProfileController.currentUser =
        navigationController?.pushViewController(showProfileController, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }


}

