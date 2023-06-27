//
//  BudgetLeaderboardView.swift
//  BudgetBuddy
//
//  Created by Muneer Lalji on 6/26/23.
//

import UIKit

class BudgetLeaderboardView: UIView {

    var budgetLeaderboard:UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupBudgetLeaderboard()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBudgetLeaderboard() {
        budgetLeaderboard = UITableView()
        budgetLeaderboard.register(BudgetLeaderboardTableViewCell.self, forCellReuseIdentifier: "leaderboard")
        budgetLeaderboard.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(budgetLeaderboard)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            budgetLeaderboard.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            budgetLeaderboard.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            budgetLeaderboard.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            budgetLeaderboard.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }

}
