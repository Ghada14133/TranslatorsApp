//
//  signUpPage.swift
//  TranslatorsCom.
//
//  Created by Ghada Fahad on 29/05/1443 AH.
//

import UIKit
import Firebase


class signUpPage: UIViewController {
    
    let userID = Auth.auth().currentUser?.uid
    
   
    let db = Firestore.firestore()
    
    
    
        let Name : UITextField = {
            let Name = UITextField()
            Name.placeholder = "Enter your name"
            Name.layer.borderWidth = 1
            Name.layer.borderColor = UIColor.black.cgColor
            return Name

        }()
    let picker : UIPickerView = {
        let pic = UIPickerView()
        return pic

    }()
    
        let emailResg : UITextField = {
            let email = UITextField()
            email.placeholder = "Enter your Email"
            email.layer.borderWidth = 1
            email.layer.borderColor = UIColor.black.cgColor
            return email

        }()
        let passwordReg : UITextField = {
            let password = UITextField()
            password.placeholder = "Enter your password"
            password.layer.borderWidth = 1
            password.layer.borderColor = UIColor.black.cgColor
            return password

        }()
        let signupBut : UIButton = {
            let signup = UIButton()
            signup.backgroundColor = .systemMint
            signup.setTitle("Sign Up", for: .normal)
            return signup

        }()
   
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            view.addSubview(Name)
            view.addSubview(passwordReg)
            view.addSubview(emailResg)
            view.addSubview(signupBut)
            
            view.backgroundColor = .white
           
            signupBut.addTarget(self, action: #selector(signB), for: .touchDown)

        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            Name.frame = CGRect(x: 30, y: 200, width: 320, height: 40)
            emailResg.frame = CGRect(x: 30, y: 250, width: 320, height: 40)
            passwordReg.frame = CGRect(x: 30, y: 300, width: 320, height: 40)
           
            signupBut.frame = CGRect(x: 30, y: 600, width: 320, height: 60)





    }
        @objc func signB() {
            Auth.auth().createUser(withEmail: emailResg.text!, password: passwordReg.text!) { authResult, error in
                if error == nil {
                    print("تم انشاء حساب جديد")
                    //save : name. userId.email
                } else {
                    print(error?.localizedDescription)
                }

            }
            if emailResg.text == "" || Name.text == ""  {
                 let alertController = UIAlertController(title: "Error", message: "Please enter your name and email and password", preferredStyle: .alert)
                 let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                 alertController.addAction(defaultAction)
                 present(alertController, animated: true, completion: nil)
               }else {
                 db.collection("Users").document("transInfo").setData(
                   [
                  "name" : Name.text!,
                   "email" : emailResg.text!,
                  "userID" :userID
                  ]
                 )
                 { error in
                   if error == nil {
                     print("You have successfully signed up")
                   
                   } else{
                     let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                     let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                     alertController.addAction(defaultAction)
                     self.present(alertController, animated: true, completion: nil)
                   }
                 }
               }
             }
            
            
            
            
        
    



//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        <#code#>
//    }
    
}

    
    




