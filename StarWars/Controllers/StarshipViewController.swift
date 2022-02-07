//
//  StarshipViewController.swift
//  StarWars
//
//  Created by Take Off Labs on 30.10.2021.
//

import Foundation
import UIKit

class StarshipViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var item1TitleLabel: UILabel!
    @IBOutlet weak var item1Label: UILabel!
    @IBOutlet weak var item2TitleLabel: UILabel!
    @IBOutlet weak var item2Label: UILabel!
    @IBOutlet weak var item3TitleLabel: UILabel!
    @IBOutlet weak var item3Label: UILabel!
    @IBOutlet weak var item4TitleLabel: UILabel!
    @IBOutlet weak var item4Label: UILabel!
    
    var starship: StarshipModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.starshipPageName
        
        titleLabel.text = starship?.name
        subtitleLabel.text = starship?.model
        
        item1TitleLabel.text = starship?.starshipClassTitle
        item1Label.text = starship?.starshipClass
        
        item2TitleLabel.text = starship?.manufacturerTitle
        item2Label.text = starship?.manufacturer
        
        item3TitleLabel.text = starship?.lengthTitle
        item3Label.text = starship?.length
        
        item4TitleLabel.text = starship?.crewTitle
        item4Label.text = starship?.crew
       
    }
    
}
