//
//  signUpTranslator.swift
//  TranslatorsCom.
//
//  Created by Ghada Fahad on 15/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseStorage


class signUpTranslator: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//    @IBOutlet weak var signButton: UIButton!
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid

    var imageName = "\(UUID().uuidString).png"
    let imageFolderReference = Storage.storage().reference().child("profileImages")

    
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
    let emailResg : UITextField = {
        let email = UITextField()
        email.placeholder = "Enter your Email"
        email.layer.borderWidth = 1
        email.layer.borderColor = UIColor.black.cgColor
        return email

    }()
    let passwordReg : UITextField = {
        let password = UITextField()
        password.placeholder = "Enter your password"
        password.layer.borderWidth = 1
        password.layer.borderColor = UIColor.black.cgColor
        return password

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
//        view.addSubview(saveButton)
        view.addSubview(transName)
        view.addSubview(profileImage)
        view.addSubview(emailResg)
        view.addSubview(passwordReg)
        view.addSubview(price)
        view.addSubview(priceField)
//        view.addSubview(signOutlet)
        
        profileImage.isUserInteractionEnabled = true
//        downloadImage()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        profileImage.addGestureRecognizer(gesture)

//        saveButton.addTarget(self, action: #selector(saveFunc), for: .touchDown)



    }
    override func viewWillLayoutSubviews() {
        profileImage.frame = CGRect(x: 100,y: 100,width: 200,height: 90)
        transName.frame = CGRect(x: 30,y: 200,width: 320,height: 30)
        emailResg.frame = CGRect(x: 30,y: 240,width: 320,height: 30)
        passwordReg.frame = CGRect(x: 30,y: 280,width: 320,height: 30)



        edu.frame = CGRect(x: 30, y: 315, width: 320, height: 30)
        degree.frame = CGRect(x: 30, y: 350, width: 320, height: 30)
        institution.frame = CGRect(x: 30, y: 400, width: 320, height: 30)
        institutionField.frame = CGRect(x: 30, y: 430, width: 320, height: 30)
        experience.frame = CGRect(x: 30, y: 480, width: 320, height: 30)
        experienceField.frame = CGRect(x: 30, y: 510, width: 320, height: 60)
        price.frame = CGRect(x: 30, y: 580, width: 320, height: 30)
        priceField.frame = CGRect(x: 30, y: 620, width: 320, height: 30)


        
        saveButton.frame = CGRect(x: 30, y: 700, width: 320, height: 30) 

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
    
    func uploadImage() {
//        let storageRef = Storage.storage().reference()
//        let uploadData = UIimagePNGRepresentation
//        storageRef.putData(<#T##uploadData: Data##Data#>)
//
//
//        "\(userID)"
        
        let imagefolder = Storage.storage().reference().child("imageProfile")
        if let imageData = profileImage.image?.pngData() {
            imagefolder.child("imageProfile").putData(imageData, metadata: nil){
                (metaData , err) in
                if let error = err {
                    print(error.localizedDescription)
                }else {
                    print("تم رفع الصورة بنجاح")


                }
//                imagefolder.child("images").downloadURL(completion: { url, error in
//                    guard let url = url, error == nil else{
//                        return
//                    }
//                    let urlString = url.absoluteString
//                    print("Download URL: \(urlString)")
//                    UserDefaults.standard.set(urlString, forKey: "url")
//                })
//            }

//        }
        
//
         
        
            }
        }
    }
    func addUser(userId: String) {
        if profileImage.image != UIImage(systemName: "person.circle") {
            downloadImage()
        }
        
        self.db.collection("translatorBio")
            .document(userId).setData( [
             "email" : emailResg.text!,
                         "password" : passwordReg.text!,

                        "transName" : transName.text,
                        "education": degree.text,
                        "institution": institutionField.text,
                        "experience": experienceField.text,
                        "userID" : userID,
             "price" : priceField.text,
             "userIcon": profileImage.image == UIImage(systemName: "person.circle") ? "nil" : imageName

                ])
        {(error) in
            if error == nil {
                print("Added Succ..")
                
            }else {
                print(error!.localizedDescription)
                
            }
        }
        
    }
    
//    @objc func saveFunc(){

//    if profileImage.image != UIImage(systemName: "person.circle") {
//        uploadImage()
//    }
//        if transName.text == "" || degree.text == "" || institutionField.text == "" || experienceField.text == "" ||  emailResg.text == "" || transName.text == ""  {        Auth.auth().createUser(withEmail: emailResg.text!, password: passwordReg.text!) { user, Error in
//
//            if Error == nil {
//                self.addUser(userId: (user?.user.uid)!)
////                let vc = TabBarVC()
////                vc.modalPresentationStyle = .fullScreen
////                self.present(vc, animated: true, completion: nil)
//
//            } else{
//                let alert = UIAlertController(title: "تنبيه", message: Error?.localizedDescription, preferredStyle: .alert)
//                                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
//                                self.present(alert, animated: true, completion: nil)
//            }
//        }
//    } else {
//        let alert = UIAlertController(title: "بيانات ناقصة", message: "الرجاء التأكد من إدخال البريد الإلكتروني و كلمة المرور", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
//                present(alert, animated: true, completion: nil)
//    }
//
        
        
        
//    if transName.text == "" || degree.text == "" || institutionField.text == "" || experienceField.text == ""  {
//         let alertController = UIAlertController(title: "Error", message: "Please complete all the fields", preferredStyle: .alert)
//         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//         alertController.addAction(defaultAction)
//         present(alertController, animated: true, completion: nil)
//
//       }else {
    
           
//    var ref: DocumentReference? = nil
//    ref = db.collection("translatorBio").addDocument(data: [
//        "transName" : transName.text,
//        "education": degree.text,
//        "institution": institutionField.text,
//        "experience": experienceField.text,
//        "userID" :userID,
//        "userIcon": profileImage.image == UIImage(systemName: "person.circle") ? "nil" : imageName
//    ]) { err in
//        if let err = err {
//            print("Error adding document: \(err)")
//        } else {
//            print("Document added with ID: \(ref!.documentID)")
//        }
//    }
    
//       }
//        let homeVc = homeTranslator()
//
//        let tabBarController = UITabBarController()
//        tabBarController.selectedIndex = 0
//        let vc = UITabBarController()
//                    vc.modalPresentationStyle = .fullScreen
//                    present(vc, animated: true, completion: nil)
                
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home") as! homeTranslator
//        present(vc, animated: true, completion: nil)
//

//}
    @IBAction func signButton(_ sender: Any) {
        
        
        
//        if profileImage.image != UIImage(systemName: "person.circle") {
//            uploadImage()
//        }
//            if transName.text == "" || degree.text == "" || institutionField.text == "" || experienceField.text == "" ||  emailResg.text == "" || transName.text == ""  {
//         let alert = UIAlertController(title: "بيانات ناقصة", message: "الرجاء التأكد من إدخال البريد الإلكتروني و كلمة المرور", preferredStyle: .alert)
//                            alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
//                            present(alert, animated: true, completion: nil)
//                }
//
//        else {
//                Auth.auth().createUser(withEmail: emailResg.text!, password: passwordReg.text!) { user, Error in
//
//                if Error == nil {
//                    self.addUser(userId: (user?.user.uid)!)
    //                let vc = TabBarVC()
    //                vc.modalPresentationStyle = .fullScreen
    //                self.present(vc, animated: true, completion: nil)

//                }
//                }
//    }
////                    else{
//
//                    let alert = UIAlertController(title: "تنبيه", message: Error?.localizedDescription, preferredStyle: .alert)
//                                    alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
//                                    self.present(alert, animated: true, completion: nil)
//                }
//            }
//        } else {
//
//            let alert = UIAlertController(title: "بيانات ناقصة", message: "الرجاء التأكد من إدخال البريد الإلكتروني و كلمة المرور", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "حسناً", style: .default, handler: nil))
//                    present(alert, animated: true, completion: nil)
//        }
            
        
        Auth.auth().createUser(withEmail: emailResg.text!, password: passwordReg.text!) { [self]  user, Error in
            
            if Error == nil {
                print("تم انشاء حساب جديد")
            } else {
                print(Error?.localizedDescription)
            }

            if self.profileImage.image != UIImage(systemName: "person.circle") {
                self.uploadImage()
        }
            if transName.text == "" || self.degree.text == "" || institutionField.text == "" || self.experienceField.text == ""  {
             let alertController = UIAlertController(title: "Error", message: "Please complete all the fields", preferredStyle: .alert)
             let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
             alertController.addAction(defaultAction)
             present(alertController, animated: true, completion: nil)
           }else {
                self.addUser(userId:  (user?.user.uid)!)
            
               
               }

               
               
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
//            }
        }

           }
           
        
        
        
    
    @objc  func didTapChangeProfilePic() {
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
        
        
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                 
                 if let imageData = selectedImage.jpegData(compressionQuality: 0.1) {
                     
                     imageFolderReference.child("imageProfile").putData(imageData, metadata: nil){
                         (metaData , err) in
                         if let error = err {
                             print(error.localizedDescription)
                         }else {
                             print("تم رفع الصورة بنجاح")
                         }
                     }
                 }
          
                  profileImage.contentMode = .scaleAspectFit
                 profileImage.image = selectedImage
              }

              dismiss(animated: true, completion: nil)
        
        //
//        picker.dismiss(animated: true, completion: nil)
//        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
//            return
//        }
//        guard let imageData = selectedImage.pngData() else {
//            return
//        }

//        self.profileImage.image = selectedImage
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    }

