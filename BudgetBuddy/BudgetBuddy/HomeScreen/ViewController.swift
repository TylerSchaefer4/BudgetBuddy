//
//  ViewController.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit

class ViewController: UIViewController {
    let homeScreen = HomeScreenView()

    
    override func loadView() {
        view = homeScreen
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Financial Summary"
        
        let profileButton = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(onProfileButtonTapped))
        
        navigationItem.rightBarButtonItem = profileButton
        hideKeyboardOnTapOutside()
        
    }
    
    @objc func onProfileButtonTapped() {
        let showProfileController = ShowProfileController()
        //showProfileController.currentUser =
        navigationController?.pushViewController(showProfileController, animated: true)
    }

    func hideKeyboardOnTapOutside(){
            //MARK: recognizing the taps on the app screen, not the keyboard...
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
            view.addGestureRecognizer(tapRecognizer)
        }
        
        @objc func hideKeyboardOnTap(){
            //MARK: removing the keyboard from screen...
            view.endEditing(true)
        }
}
