//
//  FilmCell.swift
//  StarWars
//
//  Created by Take Off Labs on 29.10.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class ReusableCell: UITableViewCell {

    
    @IBOutlet weak var item4Label: UILabel!
    @IBOutlet weak var item3Label: UILabel!
    @IBOutlet weak var item2Label: UILabel!
    @IBOutlet weak var item1Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
