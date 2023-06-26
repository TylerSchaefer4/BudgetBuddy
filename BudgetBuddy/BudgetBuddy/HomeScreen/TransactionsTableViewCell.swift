//
//  TransactionsTableViewCell.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/22/23.
//

import UIKit

class TransactionsTableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var labelAmount: UILabel!
    var labelNameOfPlace: UILabel!
    var labelDescription: UILabel!
    var labelLocation: UILabel!
    var timeStamp: Date!
    var imageUrl: UIImageView!
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setuplabelAmount()
        setuplabelNameOfPlace()
        setuplabelDescription()
        setuplabelLocation()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UIView()
        
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
    
    func setuplabelAmount(){
        labelAmount = UILabel()
        labelAmount.font = UIFont.boldSystemFont(ofSize: 20)
        labelAmount.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelAmount)
    }
    
    func setuplabelNameOfPlace() {
        labelNameOfPlace = UILabel()
        labelNameOfPlace.font = UIFont.boldSystemFont(ofSize: 16)
        labelNameOfPlace.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelNameOfPlace)
    }

    func setuplabelDescription() {
        labelDescription = UILabel()
        labelDescription.font = UIFont.systemFont(ofSize: 14)
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDescription)
    }

    func setuplabelLocation() {
        labelLocation = UILabel()
        labelLocation.font = UIFont.systemFont(ofSize: 14)
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelLocation)
    }

    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelAmount.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
            labelAmount.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            
            labelNameOfPlace.topAnchor.constraint(equalTo: labelAmount.bottomAnchor, constant: 5),
            labelNameOfPlace.leadingAnchor.constraint(equalTo: labelAmount.leadingAnchor),
            
            labelDescription.topAnchor.constraint(equalTo: labelNameOfPlace.bottomAnchor, constant: 5),
            labelDescription.leadingAnchor.constraint(equalTo: labelAmount.leadingAnchor),
            
            labelLocation.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 5),
            labelLocation.leadingAnchor.constraint(equalTo: labelAmount.leadingAnchor),
            labelLocation.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -10),
        ])
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
