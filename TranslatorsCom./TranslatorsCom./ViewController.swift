//
//  ViewController.swift
//  TranslatorsCom.
//
//  Created by Ghada Fahad on 24/05/1443 AH.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    
  
    let db = Firestore.firestore()
    
    

    @IBOutlet weak var tableView: UITableView!
    
    
    var arrTanslator = [translatprInfo]()
    
    let settingsButton : UIButton = {
        let settings = UIButton()
        settings.setImage(.init(systemName: "ellipsis.circle.fill"), for: .normal)
        settings.tintColor = .systemMint
        return settings

    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        getNames()
//        view.addSubview(tableView)
        settingsButton.addTarget(self, action: #selector(settings), for: .touchDown)

        self.tableView.register(allTranslatorCell.self, forCellReuseIdentifier: "cell")



    }
    override func viewWillLayoutSubviews() {
        settingsButton.frame = CGRect(x: 5, y: 40, width: 50, height: 100)
//        tableView.frame = CGRect(x: 10, y: 50, width: 300, height: 700)
        
        
    }
    
    @IBAction func settingsLog(_ sender: Any) {
        // create the alert
                let alert = UIAlertController(title: "Notice", message: "what would you like to do", preferredStyle: UIAlertController.Style.alert)

                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "Log in", style: UIAlertAction.Style.default, handler: {action in
                    let logVC = logIn()
                    self.present(logVC, animated: true, completion: nil)
                    
                }))
        alert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertAction.Style.default, handler: {action in
                    let sinUp = signAs()
            sinUp.modalPresentationStyle = .fullScreen
                    self.present(sinUp, animated: true, completion: nil)
                    
                }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
    }
    
    @objc func settings() {
        // create the alert
                let alert = UIAlertController(title: "Notice", message: "what would you like to do", preferredStyle: UIAlertController.Style.alert)

                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "Log in", style: UIAlertAction.Style.default, handler: {action in
                    let logVC = logIn()
                    self.present(logVC, animated: true, completion: nil)
                    
                }))
        alert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertAction.Style.default, handler: {action in
                    let sinUp = signUpPage()
                    self.present(sinUp, animated: true, completion: nil)
                    
                }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        
    
    func getNames() {
        
        db.collection("translatorBio").addSnapshotListener { querySnapshot, error in
            self.arrTanslator = []
            if let error = error {
                print("Error: ",error.localizedDescription)
            }else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let newUser = translatprInfo(
            name: data["transName"] as? String ?? "nil",
        photo:  data["userIcon"] as? String ?? "nil")
                    self.arrTanslator.append(newUser)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
//        db.collection("translatorBio").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    let name : String = document.get("transName") as! String
//                    let uid :String = document.get("userID") as! String
//
//         if uid == Auth.auth().currentUser?.uid {
//
//                                       }else{
//
//
//                    self.arrTanslator.append(translatprInfo(name: name , photo: .init(systemName: "person")!))
//                                       }
//
//                }
//            }
//            self.tableView.reloadData()
//
//        }
      
//        db.collection("translatorBio").whereField("transName", isEqualTo: true)
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
//                        self.arrTanslator.append(translatprInfo(name: , photo: <#T##UIImage#>))
//
//                    }
//                }

//        }
//        db.collection("translatorBio")
//                  .whereField("transName", isEqualTo: true)
//                  .getDocuments() { (querySnapshot, err) in
//                      if let err = err {
//                          print("Error getting documents: \(err)")
//                      } else {
//
//                          for document in querySnapshot!.documents {
//                              let data = document.data()
//                              print(data["transName"] as! String)
                              
//                          }
//                      }
//                  }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let users = arrTanslator[indexPath.row]
        cell.textLabel?.text = users.name
        cell.imageView?.image = UIImage(systemName: "person")
        
//        cell.nameLabel?.image = users.photo
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string: urlString) else {
                 return cell
              }
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            
            
            guard let data = data, error == nil else {
            return
        }
            let imageDownloded = UIImage(data: data)
            
            DispatchQueue.main.async {
                cell.imageView?.image = imageDownloded

            }

        }).resume()

          
//        cell.textLabel?.text = arrTanslator[indexPath.row].name
        
//        let translator = arrTanslator[indexPath.row]
//        cell.textLabel?.text = translatprInfo.init(name: "", photo: "")
//        let label1 = cell.viewWithTag(1) as! UILabel
//        label1.text = arrTanslator[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTanslator.count
    }
    
    struct translatprInfo {
        let name : String
        let photo : String
    }
    
}

