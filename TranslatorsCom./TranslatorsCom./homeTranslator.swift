//
//  homeTranslator.swift
//  TranslatorsCom.
//
//  Created by Ghada Fahad on 12/06/1443 AH.
//

import UIKit
import Firebase

class homeTranslator: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var navigationC: UINavigationItem!
    
    

    
    @IBOutlet weak var tableView: UITableView!
    
    var arrTanslator = [translatprInfo]()
    let db = Firestore.firestore()

    
//    let settingsButt : UIButton = {
//        let settings = UIButton()
//        settings.setImage(.init(systemName: "ellipsis.circle.fill"), for: .normal)
//        settings.tintColor = .systemMint
//        return settings
//
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
      
        loadUser()
        self.tableView.register(allTranslatorCell.self, forCellReuseIdentifier: "cell")
        
     
       
    }

    
//    override func viewWillLayoutSubviews() {
//        settingsButt.frame = CGRect(x: 5, y: 40, width: 50, height: 100)
//
//    }
    func loadUser()  {
        
//        db.collection("translatorBio").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID)")
//                }
//            }
//        }
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
    
    @IBAction func settingBar(_ sender: Any) {
        let alert = UIAlertController(title: "Notice", message: "what would you like to do", preferredStyle: UIAlertController.Style.alert)
        
        
        
        alert.addAction(UIAlertAction(title: "Sign Out", style: UIAlertAction.Style.default, handler: {(action: UIAlertAction) in
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
            let page1 = ViewController()
            self.present(page1, animated: true, completion: nil)
            page1.modalPresentationStyle = .fullScreen
        }))
                    
              
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
            
    }
    
   
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! allTranslatorCell
//        cell.nameLabel?.text = arrTanslator[indexPath.row].name
//        cell.userImage.image = arrTanslator[indexPath.row].photo
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

          
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrTanslator.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = arrTanslator[indexPath.row]
         let profileVc = translatorProfile()
        self.present(profileVc, animated: true, completion: nil)
        
    }
    struct translatprInfo {
        let name : String
        let photo : String
    }
    
    
}
