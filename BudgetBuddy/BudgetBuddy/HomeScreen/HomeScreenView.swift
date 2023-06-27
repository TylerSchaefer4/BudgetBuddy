//
//  HomeScreenView.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeScreenView: UIView {
    
    var scrollView: UIScrollView!
    var labelRecentTransactions: UILabel!
    var tableViewRecentTransactions: UITableView!
    var buttonAddTransaction: UIButton!
    var labelBudgetStatus: UILabel!
    var labelThisWeeksBudget: UILabel!
    var labelTotalAmountSpent: UILabel!
    var labelExpectedExpenses: UILabel!
    //var labelAdditionalExpenses: UILabel!
    var buttonEditBudget: UIButton!
    var buttonBudgetLeaderBoard: UIButton!
    //var tableViewBudgetLeaderBoard: UITableView!
    var buttonAddFriends: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupScrollView()
        setuplabelRecentTransactions()
        setuptableViewRecentTransactions()
        setupbuttonAddTransaction()
        setuplabelBudgetStatus()
        setuplabelThisWeeksBudget()
        setuplabelTotalAmountSpent()
        setuplabelExpectedExpenses()
        //setuplabelAdditionalExpenses()
        setupbuttonEditBudget()
        setuplabelBudgetLeaderBoard()
        setupbuttonAddFriends()
        
        initConstraints()
    }
    
    
    func setupScrollView(){
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    
    func setuplabelRecentTransactions() {
        labelRecentTransactions = UILabel()
        labelRecentTransactions.font = .boldSystemFont(ofSize: 18)
        labelRecentTransactions.text = "Recent Transactions:"
        labelRecentTransactions.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelRecentTransactions)
    }

    func setuptableViewRecentTransactions() {
        tableViewRecentTransactions = UITableView()
        tableViewRecentTransactions.register(TransactionsTableViewCell.self, forCellReuseIdentifier: "transactions")
        tableViewRecentTransactions.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(tableViewRecentTransactions)
    }
    func setupbuttonAddTransaction(){
        buttonAddTransaction = UIButton(type: .system)
        buttonAddTransaction.setTitle("Add Transaction", for: .normal)
        buttonAddTransaction.titleLabel?.font = .boldSystemFont(ofSize: 14)
        buttonAddTransaction.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(buttonAddTransaction)
    }
    func setuplabelBudgetStatus() {
        labelBudgetStatus = UILabel()
        labelBudgetStatus.text = "Budget Status"

        labelBudgetStatus.font = .boldSystemFont(ofSize: 18)
        labelBudgetStatus.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelBudgetStatus)
    }
    
    func setuplabelThisWeeksBudget() {
        labelThisWeeksBudget = UILabel()
        labelThisWeeksBudget.text = "This weeks's budget: $"

        labelThisWeeksBudget.font = .boldSystemFont(ofSize: 14)
        labelThisWeeksBudget.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelThisWeeksBudget)
    }
    func setuplabelTotalAmountSpent() {
        labelTotalAmountSpent = UILabel()
        labelTotalAmountSpent.text = "Total amount spent: $"
        labelTotalAmountSpent.font = .boldSystemFont(ofSize: 14)
        labelTotalAmountSpent.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelTotalAmountSpent)
    }
    func setuplabelExpectedExpenses(){
        labelExpectedExpenses = UILabel()
        labelExpectedExpenses.text = "Expected Expenses: $"

        labelExpectedExpenses.font = .boldSystemFont(ofSize: 14)
        labelExpectedExpenses.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(labelExpectedExpenses)
    }
//    func setuplabelAdditionalExpenses(){
//        labelAdditionalExpenses = UILabel()
//        labelAdditionalExpenses.text = "Additional Expenses: $"
//
//        labelAdditionalExpenses.font = .boldSystemFont(ofSize: 14)
//        labelAdditionalExpenses.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(labelAdditionalExpenses)
//    }
    func setupbuttonEditBudget(){
        buttonEditBudget = UIButton(type: .system)
        buttonEditBudget.setTitle("Edit", for: .normal)
        buttonEditBudget.titleLabel?.font = .boldSystemFont(ofSize: 14)
        buttonEditBudget.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(buttonEditBudget)
    }
    func setuplabelBudgetLeaderBoard(){
        buttonBudgetLeaderBoard = UIButton(type: .system)
        buttonBudgetLeaderBoard.setTitle("Budget Leaderboard", for: .normal)
        buttonBudgetLeaderBoard.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(buttonBudgetLeaderBoard)
    }
//    func setuptableViewBudgetLeaderBoard(){
//        tableViewBudgetLeaderBoard = UITableView()
//        tableViewBudgetLeaderBoard.register(FriendsTableViewCell.self, forCellReuseIdentifier: Configs.tableViewFriendsID)
//        tableViewBudgetLeaderBoard.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(tableViewBudgetLeaderBoard)
//    }
    func setupbuttonAddFriends(){
        buttonAddFriends = UIButton(type: .system)
        buttonAddFriends.setTitle("Add Friends", for: .normal)
        buttonAddFriends.titleLabel?.font = .boldSystemFont(ofSize: 14)
        buttonAddFriends.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(buttonAddFriends)
    }
    
    func initConstraints() {
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                scrollView.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
                scrollView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
                        
                
                labelRecentTransactions.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 8),
                labelRecentTransactions.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                
                tableViewRecentTransactions.topAnchor.constraint(equalTo: labelRecentTransactions.bottomAnchor, constant: 8),
                tableViewRecentTransactions.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
                tableViewRecentTransactions.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
                tableViewRecentTransactions.heightAnchor.constraint(equalToConstant: 200),
                
                buttonAddTransaction.topAnchor.constraint(equalTo: tableViewRecentTransactions.bottomAnchor, constant: 8),
                buttonAddTransaction.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                
                labelBudgetStatus.topAnchor.constraint(equalTo: buttonAddTransaction.bottomAnchor, constant: 16),
                labelBudgetStatus.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                
                labelThisWeeksBudget.topAnchor.constraint(equalTo: labelBudgetStatus.bottomAnchor, constant: 8),
                labelThisWeeksBudget.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                
                labelTotalAmountSpent.topAnchor.constraint(equalTo: labelThisWeeksBudget.bottomAnchor, constant: 8),
                labelTotalAmountSpent.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                
                labelExpectedExpenses.topAnchor.constraint(equalTo: labelTotalAmountSpent.bottomAnchor, constant: 8),
                labelExpectedExpenses.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                
//                labelAdditionalExpenses.topAnchor.constraint(equalTo: labelExpectedExpenses.bottomAnchor, constant: 8),
//                labelAdditionalExpenses.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                
                buttonEditBudget.topAnchor.constraint(equalTo: labelExpectedExpenses.bottomAnchor, constant: 8),
                buttonEditBudget.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                
                buttonBudgetLeaderBoard.topAnchor.constraint(equalTo: buttonEditBudget.bottomAnchor, constant: 16),
                buttonBudgetLeaderBoard.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                
//                tableViewBudgetLeaderBoard.topAnchor.constraint(equalTo: labelBudgetLeaderBoard.bottomAnchor, constant: 8),
//                tableViewBudgetLeaderBoard.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
//                tableViewBudgetLeaderBoard.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
                
                buttonAddFriends.topAnchor.constraint(equalTo: buttonBudgetLeaderBoard.bottomAnchor, constant: 8),
                buttonAddFriends.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                buttonAddFriends.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])
        }



    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
