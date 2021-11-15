//
//  StarshipCell.swift
//  StarWars
//
//  Created by Take Off Labs on 30.10.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

protocol StarshipCellDelegate {
    func didPressedStarshipNameButton(starshipCell: StarshipCell, selectedStarshipName: String)
}

class StarshipCell: UITableViewCell {

    @IBOutlet weak var starshipNameButton: UIButton!
    @IBOutlet weak var starshipModelLabel: UILabel!
    
    var delegate: StarshipCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func starshipNamePressed(_ sender: UIButton) {
        let selectedStarhipName = sender.currentAttributedTitle!
        delegate?.didPressedStarshipNameButton(starshipCell: self, selectedStarshipName: selectedStarhipName.string)
    }
    
}
