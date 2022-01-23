//
//  signAs.swift
//  TranslatorsCom.
//
//  Created by Ghada Fahad on 12/06/1443 AH.
//

import UIKit

class signAs: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let arrOPtions = ["translator", "client"]

    @IBOutlet weak var transOutlet: UIButton!
    let picker : UIPickerView = {
        let pic = UIPickerView()
        return pic

    }()
    let signAs : UILabel = {
        let signAs = UILabel()
        signAs.text = "Sign Up as :"
        return signAs

    }()
    let submitButton : UIButton = {
        let signup = UIButton()
        signup.backgroundColor = .systemMint
        signup.setTitle("Contonue", for: .normal)
        return signup

    }()
    let transButton : UIButton = {
        let signup = UIButton()
        signup.backgroundColor = .systemMint
        signup.setTitle("Trsanslator", for: .normal)
        return signup

    }()
    let clientButton : UIButton = {
        let signup = UIButton()
        signup.backgroundColor = .systemMint
        signup.setTitle("Client", for: .normal)
        return signup

    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(signAs)
//        view.addSubview(picker)
//        view.addSubview(submitButton)
        view.addSubview(transButton)
        view.addSubview(clientButton)
        picker.dataSource = self
        picker.delegate = self
        
        view.backgroundColor = .white
        
//        submitButton.addTarget(self, action: #selector(submitFunc), for: .touchDown)
        transButton.addTarget(self, action: #selector(transMove), for: .touchDown)
        clientButton.addTarget(self, action: #selector(clientMove), for: .touchDown)

    }
    override func viewWillLayoutSubviews() {
        signAs.frame = CGRect(x: 30, y: 350, width: 320, height: 40)
        transButton.frame = CGRect(x: 70, y: 400, width: 150, height: 40)
        clientButton.frame = CGRect(x: 70, y: 450, width: 150, height: 40)

        submitButton.frame = CGRect(x: 30, y: 600, width: 320, height: 60)

    }
    
    @IBAction func translatorButton(_ sender: Any) {
        tabBarController?.selectedIndex = 0

    }
    
    @IBAction func clientButton(_ sender: Any) {
    }
    @objc func transMove() {
        tabBarController?.selectedIndex = 0

    }
    @objc func clientMove() {
        let vc = signUpPage()
        self.present(vc, animated: true, completion: nil)
    }
    @objc func submitFunc() {
//        func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
//            if component == 0 {
//                       let transVc = transBio()
//                self.present(transVc, animated: true, completion: nil)
//                    }
//                    else{
//                        let clientVc = signUpPage()
//                        self.present(clientVc, animated: true, completion: nil)
//                    }
            
        
           
        }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrOPtions.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrOPtions[row]
    }
  
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
//        if component == 0 {
//                   let transVc = tabBarController()
//            self.present(transVc, animated: true, completion: nil)
//                }
//                else if component == 1 {
//                    let clientVc = signUpPage()
//                    self.present(clientVc, animated: true, completion: nil)
//                }
//
//
//    }

}
