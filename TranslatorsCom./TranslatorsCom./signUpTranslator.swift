//
//  signUpTranslator.swift
//  TranslatorsCom.
//
//  Created by Ghada Fahad on 15/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseStorage


class signUpTranslator: UIViewController {

    
    let transName : UITextField = {
        let name = UITextField()
        name.placeholder = "Enter your name "
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.black.cgColor
        return name

    }()
    let edu : UILabel = {
        let name = UILabel()
        name.text = "Education :"
        return name

    }()
    let degree : UITextField = {
        let name = UITextField()
        name.placeholder = "Enter your degree "
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.black.cgColor
        return name

    }()
    let institution : UILabel = {
        let name = UILabel()
        name.text = "Institution Name :"
        return name

    }()
    let institutionField : UITextField = {
        let name = UITextField()
        name.placeholder = "ex. Qassim Universtity "
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.black.cgColor
        return name

    }()
    let experience : UILabel = {
        let name = UILabel()
        name.text = "Experience :"
        return name

    }()
    let experienceField : UITextField = {
        let name = UITextField()
        name.placeholder = "ex. 1 year experience in "
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.black.cgColor
        return name

    }()
    let saveButton : UIButton = {
        let save = UIButton()
        save.backgroundColor = .systemMint
        save.setTitle("Save", for: .normal)
        return save

    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        view.addSubview(edu)
        view.addSubview(degree)
        view.addSubview(institution)
        view.addSubview(institutionField)
        view.addSubview(experience)
        view.addSubview(experienceField)
        view.addSubview(saveButton)
        view.addSubview(transName)

//        saveButton.addTarget(self, action: #selector(saveFunc), for: .touchDown)



    }
    

 

}
