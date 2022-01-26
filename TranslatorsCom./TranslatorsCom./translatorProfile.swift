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
       var nameT = ""
    let imageFolderReference = Storage.storage().reference().child("profileImages")

    let starImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star2")
        
        

//        imageView.layer.borderWidth = 2
        

        return imageView
        
    }()

    
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
    let priceLabel : UILabel = {
        let price = UILabel()
      
        return price

    }()
    
    override func loadView() {
        super.loadView()

        loadUser()
//        loadImage()
        downloadImage()
        view.addSubview(name)
        view.addSubview(nameLabel)
        view.addSubview(edu)
        view.addSubview(eduLabel)
        view.addSubview(experience)
        view.addSubview(experienceLabel)
        view.addSubview(rate)
        view.addSubview(price)
        view.addSubview(priceLabel)
        view.addSubview(askButton)
        view.addSubview(profileImage)
        nameLabel.text = nameT
        view.addSubview(starImage)
        view.backgroundColor = .white
        askButton.addTarget(self, action: #selector(ask), for: .touchDown)

        
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
        rate.frame = CGRect(x: 30, y: 430, width: 70, height: 30)
        starImage.frame = CGRect(x: 110, y: 430, width: 200, height: 40)

        price.frame = CGRect(x: 30, y: 470, width: 200, height: 40)
        priceLabel.frame = CGRect(x: 220, y: 470, width: 50, height: 40)

        askButton.frame = CGRect(x: 30, y: 600, width: 320, height: 50)
        profileImage.frame = CGRect(x: 100,y: 50,width: 200,height: 100)


        







    }
    @objc func ask() {
        let vc = chatPage()
//        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
//        let userVC = storyboard?.instantiateViewController(withIdentifier: "chat") as! chatPage
//
//        userVC.modalPresentationStyle = .fullScreen
//
//        self.navigationController?.pushViewController(userVC, animated: true)
//    }
//        let tabBarController = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
//            tabBarController.selectedIndex = 3
//            self.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: {})
        
        //
//        let vc = UITabBarItem()
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
        
        //
//        let userVC = self.storyboard?.instantiateViewController(withIdentifier: "order") as! ordersPage
//
//        userVC.modalPresentationStyle = .fullScreen
//
//        self.navigationController?.pushViewController(userVC, animated: true)
        

   
    
    //MARK: fetch user data
    func loadUser() {
        if profileImage.image != UIImage(systemName: "person.circle") {
            downloadImage()
        }
      if let userId = userID {
        db.collection("translatorBio").whereField("transName", isEqualTo: nameT).getDocuments() { (querySnapshot, error) in
          if let error = error {
            print("Error: ",error.localizedDescription)
          }else {
              for document in querySnapshot!.documents {
                                  
//              self.nameLabel.text = documentSnapshot?.get("transName") as? String
              self.eduLabel.text = document.get("education") as? String
//              self.institutionField.text = documentSnapshot?.get("institution") as? String ?? "nil"
              self.experienceLabel.text = document.get("experience") as? String ?? "nil"
                  self.priceLabel.text = document.get("price") as? String ?? "nil"


            let imgStr = document.get("userIcon") as? String
            if imgStr == "nil" {
              self.profileImage.image = UIImage(systemName: "person.circle")
            }
            else {
              sleep(2)
                self.downloadImage()
               
            }
             
             
          }
        }
      }
    }
    }
    func downloadImage(){
           
           let imageRefrence = imageFolderReference.child("imageProfile")
           
           imageRefrence.getData(maxSize: 1 * 1024 * 1024) { data, error in
             
               if error != nil {

             } else {
               
               let image = UIImage(data: data!)
               self.profileImage.contentMode = .scaleAspectFill
               self.profileImage.image = image
                 
             }
           }
    
       }
    
    
//    func loadImage() {
//        let imagefolder = Storage.storage().reference().child("profileImages")
//
//        let imageRefrence = imagefolder.child("\(userID)")
//
//                imageRefrence.getData(maxSize: 1 * 1024 * 1024) { data, error in
//                  if let error = error {
//
//                  } else {
//
//                    let image = UIImage(data: data!)
//
//                      self.profileImage.contentMode = .scaleAspectFill
//                      self.profileImage.image = image
//                  }
//                }
//
//    }
        
        
//      let url = "gs://gheras-52e4d.appspot.com/images/" + "\(imgStr)"
//      let Ref = Storage.storage().reference(forURL: url)
//      Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
//        if error != nil {
//          print("Error: Image could not download!")
//          print("===================")
//          print(error?.localizedDescription)
//        } else {
//          self.profileImage.image = UIImage(data: data!)
//        }
//      }
//    }


}
