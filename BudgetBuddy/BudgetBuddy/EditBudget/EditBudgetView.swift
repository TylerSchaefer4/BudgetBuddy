//
//  EditBudgetView.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit

class EditBudgetView: UIView {
    
    var labelThisWeeksBudget: UILabel!
    var textFieldThisWeeksBudget: UITextField!
    var labelTotalAmountSpent: UILabel!
    var textFieldTotalAmountSpent: UITextField!
    var labelExpectedExpenses: UILabel!
    var textFieldExpectedExpenses: UITextField!
//    var labelIncome: UILabel!
//    var textFieldIncome: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        
        setuplabelThisWeeksBudget()
        setuptextFieldThisWeeksBudget()
        setuplabelTotalAmountSpent()
        setuptextFieldTotalAmountSpent()
        setuplabelExpectedExpenses()
        setuptextFieldExpectedExpenses()
        //setuplabelIncome()
        //setuptextFieldIncome()

        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setuplabelThisWeeksBudget() {
        labelThisWeeksBudget = UILabel()
        labelThisWeeksBudget.font = .boldSystemFont(ofSize: 20)
        labelThisWeeksBudget.text = "This weeks Budget:"
        labelThisWeeksBudget.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelThisWeeksBudget)
    }
    
    func setuptextFieldThisWeeksBudget() {
        textFieldThisWeeksBudget = UITextField()
        textFieldThisWeeksBudget.textAlignment = .left
        textFieldThisWeeksBudget.placeholder = "This weeks budget"
        textFieldThisWeeksBudget.font = UIFont.systemFont(ofSize: 14)
        textFieldThisWeeksBudget.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldThisWeeksBudget)
    }
    func setuplabelTotalAmountSpent() {
        labelTotalAmountSpent = UILabel()
        labelTotalAmountSpent.font = .boldSystemFont(ofSize: 20)
        labelTotalAmountSpent.text = "Total amount spent:"
        labelTotalAmountSpent.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTotalAmountSpent)
    }
    func setuptextFieldTotalAmountSpent() {
        textFieldTotalAmountSpent = UITextField()
        textFieldTotalAmountSpent.textAlignment = .left
        textFieldTotalAmountSpent.placeholder = "Total amount spent"
        textFieldTotalAmountSpent.font = UIFont.systemFont(ofSize: 14)
        textFieldTotalAmountSpent.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldTotalAmountSpent)
    }
    func setuplabelExpectedExpenses() {
        labelExpectedExpenses = UILabel()
        labelExpectedExpenses.font = .boldSystemFont(ofSize: 20)
        labelExpectedExpenses.text = "Expected Expenses:"
        labelExpectedExpenses.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelExpectedExpenses)
    }
    func setuptextFieldExpectedExpenses() {
        textFieldExpectedExpenses = UITextField()
        textFieldExpectedExpenses.textAlignment = .left
        textFieldExpectedExpenses.placeholder = "Expect Expenses"
        textFieldExpectedExpenses.font = UIFont.systemFont(ofSize: 14)
        textFieldExpectedExpenses.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldExpectedExpenses)
    }
//    func setuplabelIncome() {
//        labelIncome = UILabel()
//        labelIncome.font = .boldSystemFont(ofSize: 20)
//        labelIncome.text = "Income:"
//        labelIncome.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(labelIncome)
//    }
//    func setuptextFieldIncome() {
//        textFieldIncome = UITextField()
//        textFieldIncome.textAlignment = .left
//        textFieldIncome.placeholder = "Income"
//        textFieldIncome.font = UIFont.systemFont(ofSize: 14)
//        textFieldIncome.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(textFieldIncome)
//    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelThisWeeksBudget.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            labelThisWeeksBudget.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelThisWeeksBudget.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textFieldThisWeeksBudget.topAnchor.constraint(equalTo: labelThisWeeksBudget.bottomAnchor,constant: 8),
            textFieldThisWeeksBudget.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldThisWeeksBudget.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            labelTotalAmountSpent.topAnchor.constraint(equalTo: textFieldThisWeeksBudget.bottomAnchor,constant: 8),
            labelTotalAmountSpent.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelTotalAmountSpent.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                        
            textFieldTotalAmountSpent.topAnchor.constraint(equalTo: labelTotalAmountSpent.bottomAnchor,constant: 8),
            textFieldTotalAmountSpent.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldTotalAmountSpent.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            labelExpectedExpenses.topAnchor.constraint(equalTo: textFieldTotalAmountSpent.bottomAnchor,constant: 8),
            labelExpectedExpenses.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelExpectedExpenses.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textFieldExpectedExpenses.topAnchor.constraint(equalTo: labelExpectedExpenses.bottomAnchor,constant: 8),
            textFieldExpectedExpenses.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldExpectedExpenses.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
//            labelIncome.topAnchor.constraint(equalTo: textFieldExpectedExpenses.bottomAnchor,constant: 8),
//            labelIncome.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            labelIncome.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//
//
//            textFieldIncome.topAnchor.constraint(equalTo: labelIncome.bottomAnchor,constant: 8),
//            textFieldIncome.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            textFieldIncome.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}
