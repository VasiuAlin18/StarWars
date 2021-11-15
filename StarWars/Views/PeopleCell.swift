//
//  PeopleCell.swift
//  StarWars
//
//  Created by Take Off Labs on 25.10.2021.
//

import UIKit

protocol PeopleCellDelegate {
    func didPressedNameButton(peopleCell: PeopleCell, selectedWarriorName: String)
    func didPressedSpeciesButton(peopleCell: PeopleCell, selectedWarriorName: String)
    func didPressedHomeworldButton(peopleCell: PeopleCell, selectedWarrioName: String)
}

class PeopleCell: UITableViewCell {

    @IBOutlet weak var warriorNameButton: UIButton!
    @IBOutlet weak var warriorGenderLabel: UILabel!
    @IBOutlet weak var warriorSpeciesButton: UIButton!
    @IBOutlet weak var warriorHomeworldButton: UIButton!
    
    var delegate: PeopleCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func namePressed(_ sender: UIButton) {
        let selectedWarriorName = warriorNameButton.currentTitle!
        delegate?.didPressedNameButton(peopleCell: self, selectedWarriorName: selectedWarriorName)
    }
    
    @IBAction func speciesPressed(_ sender: UIButton) {
        let selectedWarriorName = warriorNameButton.currentTitle!
        delegate?.didPressedSpeciesButton(peopleCell: self, selectedWarriorName: selectedWarriorName)
    }
    
    @IBAction func homeworldPressed(_ sender: UIButton) {
        let selectedWarriorName = warriorNameButton.currentTitle!
        delegate?.didPressedHomeworldButton(peopleCell: self, selectedWarrioName: selectedWarriorName)
    }
}
