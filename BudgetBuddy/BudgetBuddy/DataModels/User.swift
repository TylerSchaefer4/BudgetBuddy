//
//  Friend.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/22/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var budget: Int
    var spent: Int
    var expectedExpenses: Int

    
    init(name: String, email: String, budget: Int, spent: Int, expectedExpenses: Int) {
        self.name = name
        self.email = email
        self.budget = budget
        self.spent = spent
        self.expectedExpenses = expectedExpenses
    }
}

