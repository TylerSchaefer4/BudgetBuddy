//
//  RegisterFirebaseManager.swift
//  App12
//
//  Created by Sakib Miazi on 6/2/23.
//

import Foundation
import FirebaseAuth
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

extension RegisterViewController{
    
    func registerNewAccount(){
        //MARK: display the progress indicator...
        showActivityIndicator()
        //MARK: create a Firebase user with email and password...
        if let name = registerView.textFieldName.text,
           let email = registerView.textFieldEmail.text,
           let password = registerView.textFieldPassword.text{
            //Validations....
            Auth.auth().createUser(withEmail: email.lowercased(), password: password, completion: { [self]result, error in
                if error == nil{
                    //MARK: the user creation is successful...
                    self.setNameOfTheUserInFirebaseAuth(name: name)
                    
                    let user = User(name: name, email: email.lowercased(), budget: 100, spent: 0, expectedExpenses: 100)
                    
                    self.saveUserToFirestore(user: user)
                                    
                }
                    else{
                    //MARK: there is a error creating the user...
                    print(error)
                }
            })
        }
    }
    
    func saveUserToFirestore(user: User) {
        let collectionUsers = database
                        .collection("users")
                    do{
                        try collectionUsers.document(user.email)
                            .setData([
                                "name": user.name,
                                "email": user.email.lowercased(),
                                "budget": user.budget,
                                "expectedExpenses": user.expectedExpenses,
                                "spent": user.spent
                            ], completion: {(error) in
                            if error == nil{
//                                self.navigationController?.popViewController(animated: true)
                            }
                        })
                    }catch{
                        print("Error adding document!")
                    }

    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                
                //MARK: hide the progress indicator...
                self.hideActivityIndicator()
                
                //MARK: pop the current controller...
                self.navigationController?.popViewController(animated: true)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
}
