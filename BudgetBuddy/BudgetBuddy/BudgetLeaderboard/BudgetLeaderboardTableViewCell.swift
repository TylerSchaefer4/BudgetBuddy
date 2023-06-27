//
//  BudgetLeaderboardTableViewCell.swift
//  BudgetBuddy
//
//  Created by Muneer Lalji on 6/26/23.
//

import UIKit

class BudgetLeaderboardTableViewCell: UITableViewCell {
    
    var wrapperCellView:UIView!
    var nameLabel: UILabel!
    var percentLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupNameLabel()
        setupPercentLabel()
        
        initConstraints()
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(nameLabel)
    }
    
    func setupPercentLabel() {
        percentLabel = UILabel()
        percentLabel.textAlignment = .left
        percentLabel.font = UIFont.systemFont(ofSize: 18)
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(percentLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            nameLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 4),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            percentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            percentLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 4),
            percentLabel.heightAnchor.constraint(equalToConstant: 20),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
