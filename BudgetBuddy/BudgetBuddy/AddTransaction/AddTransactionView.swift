//
//  AddTransactionView.swift
//  BudgetBuddy
//
//  Created by Tyler Schaefer on 6/19/23.
//

import UIKit

class AddTransactionView: UIView {
    
    var labelType: UILabel!
    var pickerTransactionType: UIPickerView!
    var textFieldAmount: UITextField!
    var textFieldNameOfPlace: UITextField!
    var textFieldDescription: UITextField!
    var textFieldLocation: UITextField!
    var labelAttachReceipt: UILabel!
    var ReceiptPhoto: UIButton!
    let transactionTypes: [String] = ["Expense", "Income"]
    var selectedPhoneNumberType = "Expense"
    var addButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setuplabelType()
        setuppickerTransactionType()
        setuptextFieldAmount()
        setuptextFieldNameOfPlace()
        setuptextFieldDescription()
        setuptextFieldLocation()
        setuplabelAttachReceipt()
        setupReceiptPhoto()
        setupaddButton()

        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setuplabelType(){
        labelType = UILabel()
        labelType.font = .boldSystemFont(ofSize: 20)
        labelType.text = "Type:"
        labelType.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelType)
    }
    func setuppickerTransactionType() {
            pickerTransactionType = UIPickerView()
            pickerTransactionType.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(pickerTransactionType)
        }
    func setuptextFieldAmount() {
            textFieldAmount = UITextField()
            textFieldAmount.textAlignment = .left
            textFieldAmount.placeholder = "Amount"
            textFieldAmount.font = UIFont.systemFont(ofSize: 18)
            textFieldAmount.layer.borderWidth = 0.5
            textFieldAmount.layer.borderColor = UIColor.lightGray.cgColor
            textFieldAmount.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(textFieldAmount)
        }
    func setuptextFieldNameOfPlace(){
        textFieldNameOfPlace = UITextField()
        textFieldNameOfPlace.textAlignment = .left
        textFieldNameOfPlace.placeholder = "Name of place"
        textFieldNameOfPlace.font = UIFont.systemFont(ofSize: 18)
        textFieldNameOfPlace.layer.borderWidth = 0.5
        textFieldNameOfPlace.layer.borderColor = UIColor.lightGray.cgColor
        textFieldNameOfPlace.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldNameOfPlace)
    }
    func setuptextFieldDescription(){
        textFieldDescription = UITextField()
        textFieldDescription.textAlignment = .left
        textFieldDescription.placeholder = "Description"
        textFieldDescription.font = UIFont.systemFont(ofSize: 18)
        textFieldDescription.layer.borderWidth = 0.5
        textFieldDescription.layer.borderColor = UIColor.lightGray.cgColor
        textFieldDescription.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldDescription)
    }
    func setuptextFieldLocation(){
        textFieldLocation = UITextField()
        textFieldLocation.textAlignment = .left
        textFieldLocation.placeholder = "Location"
        textFieldLocation.font = UIFont.systemFont(ofSize: 18)
        textFieldLocation.layer.borderWidth = 0.5
        textFieldLocation.layer.borderColor = UIColor.lightGray.cgColor
        textFieldLocation.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldLocation)
    }
    func setuplabelAttachReceipt() {
        labelAttachReceipt = UILabel()
        labelAttachReceipt.font = .boldSystemFont(ofSize: 20)
        labelAttachReceipt.text = "Attach Receipt:"
        labelAttachReceipt.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAttachReceipt)
    }
    
    func setupReceiptPhoto() {
        ReceiptPhoto = UIButton(type: .system)
        //ReceiptPhoto.setTitle("Click Me", for: .normal)
        ReceiptPhoto.setImage(UIImage(systemName: "newspaper")?.withRenderingMode(.alwaysOriginal), for: .normal)
        //buttonTakePhoto.setImage(UIImage(systemName: "camera.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        ReceiptPhoto.contentHorizontalAlignment = .fill
        ReceiptPhoto.contentVerticalAlignment = .fill
        ReceiptPhoto.imageView?.contentMode = .scaleAspectFit
        ReceiptPhoto.showsMenuAsPrimaryAction = true
        ReceiptPhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(ReceiptPhoto)
    }
    
    func setupaddButton() {
        addButton = UIButton(type: .system)
        addButton.setTitle("Add", for: .normal)
        addButton.setImage(.add, for: .normal)
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelType.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            labelType.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            pickerTransactionType.topAnchor.constraint(equalTo: labelType.bottomAnchor,constant: 8),
            pickerTransactionType.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            pickerTransactionType.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            pickerTransactionType.heightAnchor.constraint(equalToConstant: 100),
            
            textFieldAmount.topAnchor.constraint(equalTo: pickerTransactionType.bottomAnchor,constant: 8),
            textFieldAmount.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldAmount.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                        
            textFieldNameOfPlace.topAnchor.constraint(equalTo: textFieldAmount.bottomAnchor,constant: 8),
            textFieldNameOfPlace.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldNameOfPlace.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textFieldDescription.topAnchor.constraint(equalTo: textFieldNameOfPlace.bottomAnchor,constant: 8),
            textFieldDescription.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldDescription.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textFieldLocation.topAnchor.constraint(equalTo: textFieldDescription.bottomAnchor,constant: 8),
            textFieldLocation.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldLocation.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            labelAttachReceipt.topAnchor.constraint(equalTo: textFieldLocation.bottomAnchor,constant: 8),
            labelAttachReceipt.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelAttachReceipt.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            ReceiptPhoto.topAnchor.constraint(equalTo: labelAttachReceipt.bottomAnchor,constant: 8),
            ReceiptPhoto.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            ReceiptPhoto.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            ReceiptPhoto.widthAnchor.constraint(equalToConstant: 100),
            ReceiptPhoto.heightAnchor.constraint(equalToConstant: 100),
            
            addButton.topAnchor.constraint(equalTo: ReceiptPhoto.bottomAnchor,constant: 8),
            addButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }

}
