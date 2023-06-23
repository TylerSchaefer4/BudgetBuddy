//
//  Utils.swift
//  BudgetBuddy
//
//  Created by Aakash Zaveri on 6/22/23.
//

import Foundation

import Foundation
import FirebaseFirestoreSwift

struct Contact: Codable{
    @DocumentID var id: String?
    var name: String
    var email: String
    var friends: [Contact]?
    var money: Int
    var transactions: [Transaction]?
}

struct Transaction: Codable {
    var name: String
    @DocumentID var id: String?
    var contacts: [Contact]?
    
}



