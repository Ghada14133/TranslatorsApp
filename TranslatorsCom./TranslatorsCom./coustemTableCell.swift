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
    
    
//    func setUpCell(pic: UIImage, name : String) {
//        tranName.text = name
//        photo.image = pic
//        
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    }
    




