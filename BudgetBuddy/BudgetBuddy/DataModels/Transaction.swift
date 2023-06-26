//
//  Transaction.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/22/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Transaction: Codable {
    @DocumentID var id: String?
    var type: String!
    var amount: Int!
    var nameOfPlace: String!
    var description: String!
    var location: String! // might turn this into actual GPS location?
    var timeStamp: Date!
    let imageUrl: String?
    
    init(type: String, amount: Int, nameOfPlace: String, description: String, location: String, timeStamp: Date, imageUrl: String) {
        self.type = type
        self.amount = amount
        self.nameOfPlace = nameOfPlace
        self.description = description
        self.location = location
        self.timeStamp = timeStamp
        self.imageUrl = imageUrl
    }
}
