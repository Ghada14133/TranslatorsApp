//
//  transBio.swift
//  TranslatorsCom.
//
//  Created by Ghada Fahad on 02/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseStorage


class transBio: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    var imageName = "\(UUID().uuidString).png"
    let imageFolderReference = Storage.storage().reference().child("profileImages")


    
    
    private let scrollView: UIScrollView = {
          let scrollView = UIScrollView()
          scrollView.clipsToBounds = true
        
          return scrollView
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
    let price : UILabel = {
        let name = UILabel()
        name.text = "Price :"
        return name

    }()
    let priceField : UITextField = {
        let name = UITextField()
        name.placeholder = "enter your price for every page "
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.black.cgColor
        
        return name

    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(profileImage)
        view.addSubview(scrollView)
        view.addSubview(edu)
        view.addSubview(degree)
        view.addSubview(institution)
        view.addSubview(institutionField)
        view.addSubview(experience)
        view.addSubview(experienceField)
        view.addSubview(saveButton)
        view.addSubview(transName)
        view.addSubview(price)
        view.addSubview(priceField)
        downloadImage()
        profileImage.isUserInteractionEnabled = true
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        profileImage.addGestureRecognizer(gesture)
        
        saveButton.addTarget(self, action: #selector(saveFunc), for: .touchDown)

        
    }
    
    override func viewDidLayoutSubviews() {
        profileImage.frame = CGRect(x: 100,y: 100,width: 200,height: 100)
        transName.frame = CGRect(x: 100,y: 230 ,width: 200,height: 30)

        edu.frame = CGRect(x: 30, y: 300, width: 320, height: 30)
        degree.frame = CGRect(x: 30, y: 350, width: 320, height: 30)
        institution.frame = CGRect(x: 30, y: 400, width: 320, height: 30)
        institutionField.frame = CGRect(x: 30, y: 430, width: 320, height: 30)
        experience.frame = CGRect(x: 30, y: 480, width: 320, height: 30)
        experienceField.frame = CGRect(x: 30, y: 510, width: 320, height: 60)
        price.frame = CGRect(x: 30, y: 620, width: 320, height: 30)
        priceField.frame = CGRect(x: 30, y: 660, width: 320, height: 30)


        saveButton.frame = CGRect(x: 30, y: 700, width: 320, height: 30) 
        
//        scrollView.frame = view.bounds
//              let size = scrollView.width/3
//        profileImage.frame = CGRect(x: (scrollView.width - size)/2,
//                                       y: 20,
//                                       width: size,
//                                       height: size)
//
//              profileImage.layer.cornerRadius = profileImage.width/2.0
//
    }
    override func viewWillAppear(_ animated: Bool) {
      DispatchQueue.main.async {
        self.loadUser()
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
    //MARK: fetch user data
    func loadUser() {
        if profileImage.image != UIImage(systemName: "person.circle") {
            downloadImage()
        }
      if let userId = userID {
        db.collection("translatorBio").document(userId).getDocument { documentSnapshot, error in
          if let error = error {
            print("Error: ",error.localizedDescription)
          }else {
            self.transName.text = documentSnapshot?.get("transName") as? String ?? "nil"
            self.degree.text = String(documentSnapshot?.get("education") as? String ?? "nil")
              self.institutionField.text = documentSnapshot?.get("institution") as? String ?? "nil"
              self.experienceField.text = documentSnapshot?.get("experience") as? String ?? "nil"

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
      let url = "gs://translatorsapp-ba57b.appspot.com/imageProfile" + "\(imgStr)"
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
    
    
//    func uploadImage() {
////        let storageRef = Storage.storage().reference()
////        let uploadData = UIimagePNGRepresentation
////        storageRef.putData(<#T##uploadData: Data##Data#>)
////
////
//
//
//        let imagefolder = Storage.storage().reference().child("images")
//        if let imageData = profileImage.image?.pngData() {
//            imagefolder.child("images").putData(imageData, metadata: nil){
//                (metaData , err) in
//                if let error = err {
//                    print(error.localizedDescription)
//                }else {
//                    print("تم رفع الصورة بنجاح")
//
//
//                }
//                imagefolder.child("images").downloadURL(completion: { url, error in
//                    guard let url = url, error == nil else{
//                        return
//                    }
//                    let urlString = url.absoluteString
//                    print("Download URL: \(urlString)")
//                    UserDefaults.standard.set(urlString, forKey: "url")
//                })
//            }
//
//        }
        
        
        
        
//        // Create a root reference
//        let storageRef = Storage.storage().reference()
//
//
//        // Data in memory
//        let data = profileImage.image?.jpegData(compressionQuality: 0.1) {
//                        imagefolder.child(imageName).putData(imageData, metadata: nil)
//        }
//        // Create a reference to the file you want to upload
//        let riversRef = storageRef.child("images/rivers.jpg")
//
//        // Upload the file to the path "images/rivers.jpg"
//        let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
//          guard let metadata = metadata else {
//            // Uh-oh, an error occurred!
//            return
//          }
//
//          // Metadata contains file metadata such as size, content-type.
//          let size = metadata.size
//          // You can also access to download URL after upload.
//          riversRef.downloadURL { (url, error) in
//            guard let downloadURL = url else {
//              // Uh-oh, an error occurred!
//              return
//            }
//          }
//        }
//
//        // Create a reference to the file you want to upload
//        let riversRef = storageRef.child("images/rivers.jpg")
//
//        // Upload the file to the path "images/rivers.jpg"
//        let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
//          guard let metadata = metadata else {
//            // Uh-oh, an error occurred!
//            return
//          }
//          // Metadata contains file metadata such as size, content-type.
//          let size = metadata.size
//          // You can also access to download URL after upload.
//          riversRef.downloadURL { (url, error) in
//            guard let downloadURL = url else {
//              // Uh-oh, an error occurred!
//              return
//            }
//          }
//        }
        
        // Ebtesam
//        let imagefolder = Storage.storage().reference().child("images")
//        if let imageData = profileImage.image?.jpegData(compressionQuality: 0.1) {
//            imagefolder.child(imageName).putData(imageData, metadata: nil){
//                (metaData , err) in
//                if let error = err {
//                    print(error.localizedDescription)
//                }else {
//                    print("تم رفع الصورة بنجاح")
//                }
//            }
//        }
////
//    }

 
    
    @objc private func saveFunc(){
//        if profileImage.image != UIImage(systemName: "person.circle") {
//            downloadImage()
//        }
//        if transName.text == "" || degree.text == "" || institutionField.text == "" || experienceField.text == ""  {
             let alertController = UIAlertController(title: "Error", message: "Please complete all the fields", preferredStyle: .alert)
             let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
             alertController.addAction(defaultAction)
             present(alertController, animated: true, completion: nil)
//           }else {
//
//        var ref: DocumentReference? = nil
//        ref = db.collection("translatorBio").addDocument(data: [
//            "transName" : transName.text,
//            "education": degree.text,
//            "institution": institutionField.text,
//            "experience": experienceField.text,
//            "userID" :userID,
//            "userIcon": profileImage.image == UIImage(systemName: "person.circle") ? "nil" : imageName
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//            }pn(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)

        
    }
    @objc private func didTapChangeProfilePic() {
        presentPhotoActionSheet()

    }
    
    func presentPhotoActionSheet() {
           let actionSheet = UIAlertController(title: "Profile Picture",
                                               message: "How would you like to select a picture?",
                                               preferredStyle: .actionSheet)
           actionSheet.addAction(UIAlertAction(title: "Cancel",
                                               style: .cancel,
                                               handler: nil))
           actionSheet.addAction(UIAlertAction(title: "Choose from library",
                                               style: .default,
                                               handler: { [weak self] _ in

                                                   self?.presentPhotoPicker()

           }))
        present(actionSheet, animated: true)
           }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = selectedImage.pngData() else {
            return
        }

        self.profileImage.image = selectedImage
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
