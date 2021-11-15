//
//  Starship.swift
//  StarWars
//
//  Created by Take Off Labs on 30.10.2021.
//

import Foundation
import Alamofire

enum StarshipFields: String {
    case Name = "name"
    case Model = "model"
    case Manufacturer = "manufacturer"
    case CostInCredits = "cost_in_credits"
    case Length = "length"
    case MaxAtmospheringSpeed = "max_atmospering_speed"
    case Crew = "crew"
    case Passengers = "passengers"
    case CargoCapacity = "cargo_capacity"
    case Consumables = "consumables"
    case HyperdriveRating = "hyperdrive_rating"
    case MGLT = "MGLT"
    case StarshipClass = "starship_class"
    case Pilots = "pilots"
    case Films = "films"
    case Url = "url"
}

class Starship {
    var idNumber: Int?
    var name: String?
    var model: String?
    var manufacturer: String?
    var costInCredits: String?
    var length: String?
    var maxAtmospheringSpeed: String?
    var crew: String?
    var passengers: String?
    var cargoCapacity: String?
    var consumables: String?
    var hyperdriveRating: String?
    var MGLT: String?
    var starshipClass: String?
    var pilots: [String]?
    var films: [String]?
    var url: String?
    
    var computedName: NSMutableAttributedString? {
        if let name = self.name {
            return Utils.halfTextColorChange(fullText: "Starship " + String(name), changeText: "Starship")
        }
        return nil
    }
    
    var computedModel: NSMutableAttributedString? {
        if let model = self.model {
            return Utils.halfTextColorChange(fullText: "Model " + String(model), changeText: "Model")
        }
        return nil
    }
    
    var starshipClassTitle: String {
        return "Starship Class"
    }
    
    var manufacturerTitle: String {
        return "Manufacturer"
    }
    
    var lengthTitle: String {
        return "Length"
    }
    
    var crewTitle: String {
        return "Crew"
    }
    
    init(json: [String: Any]){
        self.name = json[StarshipFields.Name.rawValue] as? String
        self.model = json[StarshipFields.Model.rawValue] as? String
        self.starshipClass = json[StarshipFields.StarshipClass.rawValue] as? String
        self.manufacturer = json[StarshipFields.Manufacturer.rawValue] as? String
        self.length = json[StarshipFields.Length.rawValue] as? String
        self.crew = json[StarshipFields.Crew.rawValue] as? String
    }
    
    class func getPeopleStarships(_ path: String, completionHandler: @escaping (Result<Starship, Error>) -> Void) {
        getStarshipAtPath(path, completionHandler: completionHandler)
    }
    
    private class func getStarshipAtPath(_ path: String, completionHandler: @escaping (Result<Starship, Error>) -> Void) {
        
        let urlData = Utils.checkURL(path)
        
        switch urlData {
        case .success(let url):
            let _ = AF.request(url).responseJSON { response in
                let result = Starship.starshipFromResponse(response)
                completionHandler(result)
            }
        case .failure(let error):
            completionHandler(.failure(error))
            return
        }
        
    }
    
    private class func starshipFromResponse(_ response: AFDataResponse<Any>) -> Result<Starship, Error> {
        
        let dataResponse = Utils.checkAPIResponse(response)
        
        switch dataResponse {
        case .success(let json):
            let starship = Starship(json: json)
            return .success(starship)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    
}
