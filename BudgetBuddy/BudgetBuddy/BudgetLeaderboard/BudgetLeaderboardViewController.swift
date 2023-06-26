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
        
        self.leaderboardView.budgetLeaderboard.delegate = self
        self.leaderboardView.budgetLeaderboard.dataSource = self
        
        self.currentUser = Auth.auth().currentUser
        
        self.getFriends()
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
                            self.friends.append(documentData)
                        }
                        catch {
                            print("error decoding documents")
                        }
                    }
                    self.friends.sort{($0.spent / $0.budget) < ($1.spent / $1.budget)}
                }
        })
    }
}

extension BudgetLeaderboardViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewLeaderboardID, for: indexPath) as! BudgetLeaderboardTableViewCell
        cell.nameLabel.text = friends[indexPath.row].name
        cell.percentLabel.text = "Spent: \(friends[indexPath.row].spent / friends[indexPath.row].budget)% of budget"
        
        return cell
    }
}
