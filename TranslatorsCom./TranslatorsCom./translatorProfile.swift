//
//  translatorProfile.swift
//  TranslatorsCom.
//
//  Created by Ghada Fahad on 02/06/1443 AH.
//

import UIKit
import Firebase

class translatorProfile: UIViewController {

    
    let userID = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()

    let profileImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.cornerRadius = imageView.frame.height/2

//        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        

        return imageView
        
    }()
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
    
    override func loadView() {
        super.loadView()

        loadUser()
        view.addSubview(name)
        view.addSubview(nameLabel)
        view.addSubview(edu)
        view.addSubview(eduLabel)
        view.addSubview(experience)
        view.addSubview(experienceLabel)
        view.addSubview(rate)
        view.addSubview(price)
        view.addSubview(askButton)
        view.addSubview(profileImage)

        view.backgroundColor = .white
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//
//
//
//
//
//
//    }
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
        profileImage.frame = CGRect(x: 100,y: 50,width: 200,height: 100)


        







    }
    
    //MARK: fetch user data
    func loadUser() {
      if let userId = userID {
        db.collection("translatorBio").document(userId).getDocument { documentSnapshot, error in
          if let error = error {
            print("Error: ",error.localizedDescription)
          }else {
              self.nameLabel.text = documentSnapshot?.get("name") as? String ?? "nil"
              self.eduLabel.text = String(documentSnapshot?.get("education") as? String ?? "nil")
//              self.institutionField.text = documentSnapshot?.get("institution") as? String ?? "nil"
              self.experienceLabel.text = documentSnapshot?.get("experience") as? String ?? "nil"

            let imgStr = documentSnapshot?.get("userIcon") as? String
            if imgStr == "nil" {
              self.profileImage.image = UIImage(systemName: "person.circle")
            }
            else {
              sleep(2)
              self.loadImage(imgStr: imgStr!)
               
            }
             
             
          }
        }
      }
    }
    func loadImage(imgStr: String) {
      let url = "gs://gheras-52e4d.appspot.com/images/" + "\(imgStr)"
      let Ref = Storage.storage().reference(forURL: url)
      Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
        if error != nil {
          print("Error: Image could not download!")
          print("===================")
          print(error?.localizedDescription)
        } else {
          self.profileImage.image = UIImage(data: data!)
        }
      }
    }


}
