//
//  ShowErrorAlert.swift
//  BudgetBuddy
//
//  Created by Muneer Lalji on 6/25/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showErrorAlert(_ error: String) {
        let alert = UIAlertController(title: "Error!", message: error, preferredStyle: .alert)
                
        alert.addAction(UIAlertAction(title: "OK", style: .default))
                
        self.present(alert, animated: true)
    }
    
}
