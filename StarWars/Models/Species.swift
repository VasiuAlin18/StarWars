//
//  Species.swift
//  StarWars
//
//  Created by Take Off Labs on 31.10.2021.
//

import Foundation
import Alamofire

enum SpeciesFields: String {
    case Name = "name"
    case Classification = "classification"
    case Designation = "designation"
    case AverageHeight = "average_height"
}

class Species {
    var idNumber: Int?
    var name: String?
    var classification: String?
    var designation: String?
    var averageHeight: String?
    
    var computedClassification: NSMutableAttributedString? {
        if let cls = self.classification {
            return Utils.halfTextColorChange(fullText: "Classification " + String(cls), changeText: "Classification")
        }
        return nil
    }
    
    var computedDesignation: NSMutableAttributedString? {
        if let des = self.designation {
            return Utils.halfTextColorChange(fullText: "Designation " + String(des), changeText: "Designation")
        }
        return nil
    }
    
    var computedAverageHeight: NSMutableAttributedString? {
        if let avgHeight = self.averageHeight {
            return Utils.halfTextColorChange(fullText: "Average Height " + String(avgHeight), changeText: "Average Height")
        }
        return nil
    }
    
    init(json: [String: Any]){
        self.name = json[SpeciesFields.Name.rawValue] as? String
        self.classification = json[SpeciesFields.Classification.rawValue] as? String
        self.designation = json[SpeciesFields.Designation.rawValue] as? String
        self.averageHeight = json[SpeciesFields.AverageHeight.rawValue] as? String
    }
    
    class func getPeopleSpecies(_ path: String, completionHandler: @escaping (Result<Species, Error>) -> Void) {
        getSpeciesAtPath(path, completionHandler: completionHandler)
    }
    
    private class func getSpeciesAtPath(_ path: String, completionHandler: @escaping (Result<Species, Error>) -> Void) {
        
        let urlData = Utils.checkURL(path)
        
        switch urlData {
        case .success(let url):
            let _ = AF.request(url).responseJSON { response in
                let result = Species.speciesFromResponse(response)
                completionHandler(result)
            }
        case .failure(let error):
            completionHandler(.failure(error))
            return
        }
        
    }
    
    private class func speciesFromResponse(_ response: AFDataResponse<Any>) -> Result<Species, Error> {
        
        let dataResponse = Utils.checkAPIResponse(response)
        
        switch dataResponse {
        case .success(let json):
            let species = Species(json: json)
            return .success(species)
        case .failure(let error):
            return .failure(error)
        }
    }
    
}

