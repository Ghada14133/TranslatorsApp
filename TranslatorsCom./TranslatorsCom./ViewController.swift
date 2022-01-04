//
//  ViewController.swift
//  TranslatorsCom.
//
//  Created by Ghada Fahad on 24/05/1443 AH.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    

    
    

    @IBOutlet weak var tableView: UITableView!
    

    
    let settingsButton : UIButton = {
        let settings = UIButton()
        settings.setImage(.init(systemName: "ellipsis.circle.fill"), for: .normal)
        settings.tintColor = .black
        return settings

    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(settingsButton)
//        view.addSubview(tableView)




    }
    override func viewWillLayoutSubviews() {
        settingsButton.frame = CGRect(x: 5, y: 40, width: 50, height: 100)
//        tableView.frame = CGRect(x: 10, y: 50, width: 300, height: 700)
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Noura"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    

}

