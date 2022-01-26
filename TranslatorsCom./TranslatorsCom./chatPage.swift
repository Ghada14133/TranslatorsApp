//
//  chatPage.swift
//  TranslatorsCom.
//
//  Created by Ghada Fahad on 22/06/1443 AH.
//

import UIKit
import Firebase
class chatPage: UIViewController {
    let addFile : UIButton = {
        let add = UIButton()
        add.setImage(.init(systemName: "plus"), for: .normal)
//        add.setTitle("Send Files", for: .normal)
        add.setTitleColor(.systemMint, for: .normal)
        add.tintColor = .systemMint
        
        return add
    }()
    
    
    let message : UITextField = {
        let msg = UITextField()
        msg.placeholder = "Enter your message here"
        msg.layer.borderWidth = 1
        msg.layer.borderColor = UIColor.black.cgColor
        return msg
    }()
    let send : UIButton = {
        let save = UIButton()
        save.backgroundColor = .systemMint
        save.setTitle("send", for: .normal)
        return save

    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(addFile)
        view.addSubview(message)
        view.addSubview(send)
//        addFile.addTarget(self, action: #selector(add), for: .touchDown)
        view.backgroundColor = .white
    }
    
//    @objc func add() {
//    // Get a reference to the storage service using the default Firebase App
//    let storage = Storage.storage()
//
//    // Create a storage reference from our storage service
//    let storageRef = storage.reference()
//
//    // File located on disk
//    let localFile = URL(string: "path/to/docs/rivers.pdf")!
//
//        // Create a reference to the file you want to upload
//        let riversRef = storageRef.child("docs/rivers.pdf")
//
//        // Upload the file to the path "docs/rivers.pdf"
//        let uploadTask = riversRef.putFile(from: localFile, metadata: nil) { metadata, error in
//          guard let metadata = metadata else {
//            // Uh-oh, an error occurred!
//            return
//          }
//          // Metadata contains file metadata such as size, content-type.
//          let size = metadata.size
//          // You can also access to download URL after upload.
//          storageRef.downloadURL { (url, error) in
//            guard let downloadURL = url else {
//              // Uh-oh, an error occurred!
//              return
//            }
//          }
//        }
//    }
    
    @IBAction func settingButton(_ sender: Any) {
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
    override func viewWillLayoutSubviews() {
        addFile.frame = CGRect(x: 300, y: 100, width: 100, height: 40)
        message.frame = CGRect(x: 20, y: 670, width: 300, height: 40)
        send.frame = CGRect(x: 330, y: 670, width: 50, height: 40)


    }
}



