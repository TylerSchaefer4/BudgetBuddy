//
//  ShowProfileView.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit

class ShowProfileView: UIView {
    
    //var profilePic: UIImageView!
    var labelName: UILabel!
    var labelEmail: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        //setupProfilePic()
        setupLabelName()
        setupLabelEmail()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
//            profilePic.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
//            profilePic.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
//            profilePic.heightAnchor.constraint(equalToConstant: 100),
//            profilePic.widthAnchor.constraint(equalToConstant: 100),
            
            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            labelName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
            labelEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
    
//    func setupProfilePic() {
//        profilePic = UIImageView()
//        profilePic.image = UIImage(systemName: "person.fill")
//        profilePic.tintColor = .black
//        profilePic.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(profilePic)
//    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.text = "Name"
        labelName.textAlignment = .center
        labelName.font = UIFont.boldSystemFont(ofSize: 24)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }

    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.text = "Email"
        labelEmail.textAlignment = .left
        labelEmail.font = UIFont.systemFont(ofSize: 18)
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }

}
