//
//  PlanetManager.swift
//  StarWars
//
//  Created by Take Off Labs on 31.10.2021.
//

import Foundation

protocol PlanetManagerDelegate {
    func didFetchPlanetData(planetManager: PlanetManager, planet: Planet)
    func didFailWithError(error: Error)
}

class PlanetManager {
    
    var delegate: PlanetManagerDelegate?
    
    func fetchPlanet(path: String) {
        Planet.getPeoplePlanet(path) { result in
            print(result)
            switch result {
            case .success(let planet):
                self.delegate?.didFetchPlanetData(planetManager: self, planet: planet)
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
    
}
