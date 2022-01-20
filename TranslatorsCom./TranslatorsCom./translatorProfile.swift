//
//  translatorProfile.swift
//  TranslatorsCom.
//
//  Created by Ghada Fahad on 02/06/1443 AH.
//

import UIKit

class translatorProfile: UIViewController {

    let askButton : UIButton = {
        let ask = UIButton()
        ask.backgroundColor = .systemMint
        ask.setTitle("Ask for translation", for: .normal)
        return ask

    }()
    let name : UILabel = {
        let name = UILabel()
        name.text = "Name :"
        return name

    }()
    let nameLabel : UILabel = {
        let name = UILabel()
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.black.cgColor
        return name

    }()
    let edu : UILabel = {
        let edu = UILabel()
        edu.text = "Education :"
        return edu

    }()
    let eduLabel : UILabel = {
        let edu = UILabel()
        edu.layer.borderWidth = 1
        edu.layer.borderColor = UIColor.black.cgColor
        return edu

    }()
    let experience : UILabel = {
        let ex = UILabel()
        ex.text = "experience :"
        return ex

    }()
    let experienceLabel : UILabel = {
        let exper = UILabel()
        exper.layer.borderWidth = 1
        exper.layer.borderColor = UIColor.black.cgColor
        return exper

    }()
    let rate : UILabel = {
        let rate = UILabel()
        rate.text = "Ratings :"
        return rate

    }()
    
    let price : UILabel = {
        let price = UILabel()
        price.text = "price for the page :"
        return price

    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(name)
        view.addSubview(nameLabel)
        view.addSubview(edu)
        view.addSubview(eduLabel)
        view.addSubview(experience)
        view.addSubview(experienceLabel)
        view.addSubview(rate)
        view.addSubview(price)
        view.addSubview(askButton)










    }
    override func viewWillLayoutSubviews() {
        name.frame = CGRect(x: 30, y: 150, width: 320, height: 30)
        nameLabel.frame = CGRect(x: 30, y: 180, width: 320, height: 40)
        edu.frame = CGRect(x: 30, y: 230, width: 320, height: 30)
        eduLabel.frame = CGRect(x: 30, y: 260, width: 320, height: 50)
        experience.frame = CGRect(x: 30, y: 320, width: 320, height: 30)
        experienceLabel.frame = CGRect(x: 30, y: 350, width: 320, height: 50)
        rate.frame = CGRect(x: 30, y: 430, width: 320, height: 30)
        price.frame = CGRect(x: 30, y: 470, width: 320, height: 40)
        askButton.frame = CGRect(x: 30, y: 600, width: 320, height: 50)

        







    }


}
