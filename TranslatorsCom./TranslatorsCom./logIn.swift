//
//  logIn.swift
//  TranslatorsCom.
//
//  Created by Ghada Fahad on 26/05/1443 AH.
//

import UIKit
import Firebase

class logIn: UIViewController {
    
    let login : UITextField = {
        let log = UITextField()
        log.placeholder = "Enter your email"
        log.layer.borderWidth = 1
        return log
    }()
    let password : UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.layer.borderWidth = 1
        password.isSecureTextEntry = true
        password.layer.borderColor = UIColor.black.cgColor
        return password

    }()
    let signupButton : UIButton = {
        let signup = UIButton()
       signup.setTitle("sign up", for: .normal)
        signup.setTitleColor(.systemMint, for: .normal)
        //
        return signup

    }()
    
    let loginButton : UIButton = {
        let logButton = UIButton()
        logButton.backgroundColor = .systemMint
        logButton.setTitle("Sign In", for: .normal)
        return logButton

    }()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(login)
        view.addSubview(password)
        view.addSubview(loginButton)
        
        
        
        
        loginButton.addTarget(self, action: #selector(signFunc), for: .touchDown)
        signupButton.addTarget(self, action: #selector(signUPBut), for: .touchDown)

        

    }
    override func viewWillLayoutSubviews() {
        login.frame = CGRect(x: 30, y: 300, width: 320, height: 50)
        password.frame = CGRect(x: 30, y: 370, width: 320, height: 50)
        signupButton.frame = CGRect(x: 50, y: 700, width: 300, height: 40)
        loginButton.frame = CGRect(x: 30, y: 500, width: 320, height: 60)

    }

    @objc func signFunc() {

        Auth.auth().signIn(withEmail: login.text!, password: password.text!) { authResult, error in
        if error == nil {
            let thirdVC = ViewController()
            self.present(thirdVC, animated: true, completion: nil)
            thirdVC.modalTransitionStyle = .crossDissolve
            thirdVC.modalPresentationStyle = .fullScreen
        } else {
            print(error?.localizedDescription)

}
}
}
    
    @objc func signUPBut() {
        let seconVC = signUpPage()
        self.present(seconVC, animated: true, completion: nil)
}
    
    
}
