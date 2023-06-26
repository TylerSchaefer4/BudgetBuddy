//
//  AddFriendView.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit

class AddFriendView: UIView {
    
    var emailTextField:UITextField!
    var addFriendButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupEmailTextField()
        setupAddFriendButton()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            emailTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 150),
            
            addFriendButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            addFriendButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            addFriendButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.textAlignment = .center
        emailTextField.font = UIFont.systemFont(ofSize: 18)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailTextField)
    }
    
    func setupAddFriendButton() {
        addFriendButton = UIButton(type: .system)
        addFriendButton.setTitle("Add Friend", for: .normal)
        addFriendButton.backgroundColor = .blue
        addFriendButton.tintColor = .white
        addFriendButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        addFriendButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addFriendButton)
    }

}
