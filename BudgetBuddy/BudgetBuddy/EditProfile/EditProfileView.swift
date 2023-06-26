//
//  EditProfileView.swift
//  BudgetBuddy
//
//  Created by Muneer Lalji on 6/21/23.
//

import UIKit

class EditProfileView: UIView {
    
//    var buttonTakePhoto:UIButton!
    var nameTextField:UITextField!
    var emailTextField:UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
//        setupbuttonTakePhoto()
        setupNameTextField()
        setupEmailTextField()
        
        initConstraints()
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
//            buttonTakePhoto.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
//            buttonTakePhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 100),
//            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 100),
            
            nameTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
//    func setupbuttonTakePhoto(){
//        buttonTakePhoto = UIButton(type: .system)
//        buttonTakePhoto.setTitle("", for: .normal)
//        buttonTakePhoto.setImage(UIImage(systemName: "camera.fill"), for: .normal)
//        buttonTakePhoto.contentHorizontalAlignment = .fill
//        buttonTakePhoto.contentVerticalAlignment = .fill
//        buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
//        buttonTakePhoto.showsMenuAsPrimaryAction = true
//        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(buttonTakePhoto)
//    }
    
    func setupNameTextField() {
        nameTextField = UITextField()
        nameTextField.textAlignment = .left
        nameTextField.borderStyle = .roundedRect
        nameTextField.placeholder = "Name"
        nameTextField.font = UIFont.systemFont(ofSize: 14)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameTextField)
    }
    
    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.textAlignment = .left
        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont.systemFont(ofSize: 14)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailTextField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
