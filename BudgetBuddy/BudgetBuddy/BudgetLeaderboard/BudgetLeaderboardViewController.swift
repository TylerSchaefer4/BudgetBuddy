//
//  BudgetLeaderboardViewController.swift
//  BudgetBuddy
//
//  Created by Muneer Lalji on 6/26/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class BudgetLeaderboardViewController: UIViewController {
    
    let leaderboardView = BudgetLeaderboardView()
    
    let database = Firestore.firestore()
    
    var currentUser:FirebaseAuth.User!
    
    var friends:[User]!
    
    override func loadView() {
        view = leaderboardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Budget Leaderboard"
        
        self.leaderboardView.budgetLeaderboard.delegate = self
        self.leaderboardView.budgetLeaderboard.dataSource = self
        
        self.currentUser = Auth.auth().currentUser
        
        self.getFriends()
        
        print("hdeunfunru")
        self.friends.sort{($0.spent / $0.budget) < ($1.spent / $1.budget)}
        self.leaderboardView.budgetLeaderboard.reloadData()
    }
    
    func getFriends() {
        database.collection("users").document(self.currentUser.email!).collection("friends").getDocuments(completion: {(querySnapshot, error) in
            if let error = error {
                    // Handle any errors
                    print("Error getting documents: \(error)")
                } else {
                    // Iterate over the query snapshot to access the documents
                    for document in querySnapshot!.documents {
                        do {
                            let documentData = try document.data(as: User.self)
                            print(documentData.name)
                            self.database.collection("users").document(documentData.email.lowercased()).getDocument(as: User.self) {result in
                                switch result {
                                    case .success(let document):
                                        print("document: \(document)")
                                        self.friends.append(document)
                                        self.friends.sort{($0.spent / $0.budget) < ($1.spent / $1.budget)}
                                        self.leaderboardView.budgetLeaderboard.reloadData()
                                        break
                                    case .failure(let error):
                                        // Handle the error
                                        print("Error retrieving document: \(error)")
                                        break
                                }
                            }
                            //self.friends.append(documentData)
                        }
                        catch {
                            print("error decoding documents")
                        }
                    }
//                    print("sort and reload")
//                    self.friends.sort{($0.spent / $0.budget) < ($1.spent / $1.budget)}
//                    print(self.friends!)
//                    self.leaderboardView.budgetLeaderboard.reloadData()
                }
        })
    }
    
    func getFriendsHelp(friend: User) {
        
    }
}

extension BudgetLeaderboardViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(friends.count)
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboard", for: indexPath) as! BudgetLeaderboardTableViewCell
        cell.nameLabel.text = friends[indexPath.row].name
        print("\(cell.nameLabel.text): \(friends[indexPath.row].spent)")
        cell.percentLabel.text = "Spent: \((Double(friends[indexPath.row].spent) / Double(friends[indexPath.row].budget)) * 100)% of budget"
        
        return cell
    }
}
