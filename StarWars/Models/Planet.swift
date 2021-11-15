//
//  Planet.swift
//  StarWars
//
//  Created by Take Off Labs on 31.10.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import Alamofire



enum PlanetFields: String {
    case Name = "name"
    case RotationPeriod = "rotation_period"
    case OrbitalPeriod = "orbital_period"
    case Diameter = "diameter"
    case Climate = "climate"
    case Population = "population"
}

class Planet {
    var idNumber: Int?
    var name: String?
    var population: String?
    var climate: String?
    var diameter: String?
    var rotationPeriod: String?
    var orbitalPeriod: String?
    
    var populationTitle: String {
        return "Population"
    }
    
    var climateTitle: String {
        return "Climate"
    }
    
    var diameterTitle: String {
        return "Diameter"
    }
    
    var rotationPeriodTitle: String {
        return "Rotation Period"
    }
    
    var orbitalPeriodTitle: String {
        return "Orbital Period"
    }
    
    init(json: [String: Any]) {
        self.name = json[PlanetFields.Name.rawValue] as? String
        self.population = json[PlanetFields.Population.rawValue] as? String
        self.climate = json[PlanetFields.Climate.rawValue] as? String
        self.diameter = json[PlanetFields.Diameter.rawValue] as? String
        self.rotationPeriod = json[PlanetFields.RotationPeriod.rawValue] as? String
        self.orbitalPeriod = json[PlanetFields.OrbitalPeriod.rawValue] as? String
    }
    
    class func getPeoplePlanet(_ path: String, completionHandler: @escaping (Result<Planet, Error>) -> Void) {
        getPlanetAtPath(path, completionHandler: completionHandler)
    }
    
    private class func getPlanetAtPath(_ path: String, completionHandler: @escaping (Result<Planet, Error>) -> Void) {
        
        let urlData = Utils.checkURL(path)
        
        switch urlData {
        case .success(let url):
            let _ = AF.request(url).responseJSON { response in
                let result = Planet.planetFromResponse(response)
                completionHandler(result)
            }
        case .failure(let error):
            completionHandler(.failure(error))
            return
        }
        
    }
    
    private class func planetFromResponse(_ response: AFDataResponse<Any>) -> Result<Planet, Error> {
        
        let dataResponse = Utils.checkAPIResponse(response)
        
        switch dataResponse {
        case .success(let json):
            let planet = Planet(json: json)
            return .success(planet)
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
