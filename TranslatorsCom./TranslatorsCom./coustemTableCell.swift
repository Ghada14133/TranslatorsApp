//
//  coustemTableCell.swift
//  TranslatorsCom.
//
//  Created by Ghada Fahad on 03/06/1443 AH.
//

import UIKit

class coustemTableCell: UITableViewCell {

  
    @IBOutlet weak var tranName: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    
    
    func setUpCell(pic: UIImage, name : String) {
        tranName.text = name
        photo.image = pic
        
    }
    
    }
    




