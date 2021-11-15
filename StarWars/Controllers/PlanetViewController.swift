//
//  PlanetViewController.swift
//  StarWars
//
//  Created by Take Off Labs on 31.10.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

class PlanetViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var item1TitleLabel: UILabel!
    @IBOutlet weak var item1Label: UILabel!
    @IBOutlet weak var item2TitleLabel: UILabel!
    @IBOutlet weak var item2Label: UILabel!
    @IBOutlet weak var item3TitleLabel: UILabel!
    @IBOutlet weak var item3Label: UILabel!
    @IBOutlet weak var item4TitleLabel: UILabel!
    @IBOutlet weak var item4Label: UILabel!
    @IBOutlet weak var item5TitleLabel: UILabel!
    @IBOutlet weak var item5Label: UILabel!
    
    var planetURL: String?
    var planetManager = PlanetManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.homeworldPageName
        
        planetManager.delegate = self
        
        if let safePlanetURL = planetURL {
            planetManager.fetchPlanet(path: safePlanetURL)
        }
        
    }
}

extension PlanetViewController: PlanetManagerDelegate {
    func didFetchPlanetData(planetManager: PlanetManager, planet: Planet) {
        DispatchQueue.main.async {
            self.titleLabel.text = planet.name
            self.item1TitleLabel.text = planet.populationTitle
            self.item1Label.text = planet.population
            self.item2TitleLabel.text = planet.climateTitle
            self.item2Label.text = planet.climate
            self.item3TitleLabel.text = planet.diameterTitle
            self.item3Label.text = planet.diameter
            self.item4TitleLabel.text = planet.rotationPeriodTitle
            self.item4Label.text = planet.rotationPeriod
            self.item5TitleLabel.text = planet.orbitalPeriodTitle
            self.item5Label.text = planet.orbitalPeriod
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
