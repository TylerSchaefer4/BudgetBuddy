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

    
    override func loadView() {
        view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Financial Summary"
        
        let profileButton = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(onProfileButtonTapped))

        navigationItem.rightBarButtonItem = profileButton

        
        homeScreen.tableViewRecentTransactions.delegate = self
        homeScreen.tableViewRecentTransactions.dataSource = self
        homeScreen.tableViewRecentTransactions.separatorStyle = .none


        self.homeScreen.buttonAddTransaction.addTarget(self, action: #selector(onButtonAddTransaction), for: .touchUpInside)
        
        self.homeScreen.buttonEditBudget.addTarget(self, action: #selector(onButtonEditBudget), for: .touchUpInside)
        self.homeScreen.buttonAddFriends.addTarget(self, action: #selector(onButtonAddFriends), for: .touchUpInside)
        self.homeScreen.buttonBudgetLeaderBoard.addTarget(self, action: #selector(onButtonBudgetLeaderboard), for: .touchUpInside)

        hideKeyboardOnTapOutside()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeScreen.tableViewRecentTransactions.delegate = self
        homeScreen.tableViewRecentTransactions.dataSource = self
        
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
//                self.mainScreen.labelText.text = "Please sign in to see the notes!"
//                self.mainScreen.floatingButtonAddContact.isEnabled = false
//                self.mainScreen.floatingButtonAddContact.isHidden = true
//
//                //MARK: Reset tableView...
//                self.contactsList.removeAll()
//                self.mainScreen.tableViewContacts.reloadData()
                
                //MARK: Sign in bar button...
                self.setupRightBarButton(isLoggedin: false)
                
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
//                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
//                self.mainScreen.floatingButtonAddContact.isEnabled = true
//                self.mainScreen.floatingButtonAddContact.isHidden = false
                
                //MARK: Logout bar button...
                self.setupRightBarButton(isLoggedin: true)
                
                let usersCollection = self.database.collection("users")
                let email = self.currentUser?.email
                //print(email)
//                // set values on home screen
                usersCollection.whereField("email", isEqualTo: self.currentUser?.email)
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
                            let user = document.data() // Access the user data as a dictionary
                            print(user)
                            
                            // Access the specific fields
                            if let name = user["name"] as? String,
                               let budget = user["budget"] as? Int,
                               let spent = user["spent"] as? Int,
                               let expectedExpenses = user["expectedExpenses"] as? Int {
                                // Create a User object or perform further operations with the data
//                                let userObject = User(name: name, email: self.currentUser?.email! ?? "", budget: budget, spent: spent, expectedExpenses: expectedExpenses)
//
//                                // Access the user properties here
//                                print("User name: \(userObject.name)")
//                                print("User email: \(userObject.email)")
//                                print("User budget: \(userObject.budget)")
//                                print("User spent: \(userObject.spent)")
//                                print("User expectedExpenses: \(userObject.expectedExpenses)")
                                self.homeScreen.labelThisWeeksBudget.text = "This weeks's budget: $" + String(budget)
                                self.homeScreen.labelTotalAmountSpent.text = "Total amount spent: $" + String(spent)
                                self.homeScreen.labelExpectedExpenses.text = "Expected Expenses: $" + String(expectedExpenses)
                            }
                        }
                        
                        
                        self.database.collection("users")
                        .document((self.currentUser?.email)!)
                        .collection("transactions")
                        .addSnapshotListener(includeMetadataChanges: false, listener: { querySnapshot, error in
                            if let documents = querySnapshot?.documents {
                                self.transactions.removeAll()
                                for document in documents {
                                    do {
                                        let transaction  = try document.data(as: Transaction.self)
                                        self.transactions.append(transaction)
                                    } catch {
                                        print(error)
                                    }
                                }
                                print("Transactions: \(self.transactions)")
                                DispatchQueue.main.async {
                                    self.homeScreen.tableViewRecentTransactions.reloadData()
                                }

                            }
                        })


                    }



//                homeScreen.labelThisWeeksBudget = 100
                
                //MARK: Observe Firestore database to display the contacts list...
                self.database.collection("users")
                    .document((self.currentUser?.email)!)
                    .collection("contacts")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents{
//                            self.contactsList.removeAll()
//                            for document in documents{
//                                do{
//                                    let contact  = try document.data(as: Contact.self)
//                                    self.contactsList.append(contact)
//                                }catch{
//                                    print(error)
//                                }
//                            }
//                            self.contactsList.sort(by: {$0.name < $1.name})
//                            self.mainScreen.tableViewContacts.reloadData()
                        }
                    })
                
            }
        }
    }
    
    @objc func onButtonBudgetLeaderboard() {
        let leaderboard = BudgetLeaderboardViewController()
        leaderboard.friends = [User]()
        navigationController?.pushViewController(leaderboard, animated: true)
    }
    
    @objc func onButtonAddTransaction() {
        let addTransactionViewController = AddTransactionViewController()
        //showProfileController.currentUser =
        navigationController?.pushViewController(addTransactionViewController, animated: true)
    }
    
    @objc func onButtonEditBudget() {
        let editBudgetController = EditBudgetController()
        //showProfileController.currentUser =
        navigationController?.pushViewController(editBudgetController, animated: true)
    }
    
    @objc func onButtonAddFriends() {
        let addFriendsController = AddFriendController()
        //showProfileController.currentUser =
        navigationController?.pushViewController(addFriendsController, animated: true)
    }
    
    @objc func onProfileButtonTapped() {
        let showProfileController = ShowProfileController()
        //showProfileController.currentUser =
        navigationController?.pushViewController(showProfileController, animated: true)
    }

    func hideKeyboardOnTapOutside(){
            //MARK: recognizing the taps on the app screen, not the keyboard...
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
            view.addGestureRecognizer(tapRecognizer)
        }
        
        @objc func hideKeyboardOnTap(){
            //MARK: removing the keyboard from screen...
            view.endEditing(true)
        }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactions", for: indexPath) as! TransactionsTableViewCell
        let transaction = transactions[indexPath.row]
        cell.labelAmount.text = "$\(transaction.amount ?? 0)"
        cell.labelNameOfPlace.text = transaction.nameOfPlace
        cell.labelDescription.text = transaction.description
        cell.labelLocation.text = transaction.location
        print("YOOYOYOOYOOYOYOOY")
        print(transaction)
        
        return cell
    }

}


