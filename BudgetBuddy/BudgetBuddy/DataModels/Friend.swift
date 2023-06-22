//
//  Friend.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/22/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Friend: Codable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var photoURL: String?

    
    init(name: String, email: String, photoURL: String?) {
        self.name = name
        self.email = email
        self.photoURL = photoURL
    }
}

