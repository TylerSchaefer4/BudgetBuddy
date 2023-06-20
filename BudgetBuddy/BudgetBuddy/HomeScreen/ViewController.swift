//
//  ViewController.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileButton = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(onProfileButtonTapped))
        
        navigationItem.rightBarButtonItem = profileButton
    }
    
    @objc func onProfileButtonTapped() {
        
    }


}

