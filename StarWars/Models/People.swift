//
//  People.swift
//  StarWars
//
//  Created by Take Off Labs on 25.10.2021.
//

import Foundation
import Alamofire

class PeopleWrapper {
    var results: [People]?
    var count: Int?
    var next: String?
    var previous: String?
}

enum PeopleFields: String {
    case Name = "name"
    case Height = "height"
    case Mass = "mass"
    case HairColor = "hair_color"
    case SkinColor = "skin_color"
    case EyeColor = "eye_color"
    case BirthYear = "birth_year"
    case Gender = "gender"
    case Homeworld = "homeworld"
    case Films = "films"
    case Species = "species"
    case Vehicles = "vehicles"
    case Starships = "starships"
    case Url = "url"
}

class People {
    var idNumber: Int?
    var name: String?
    var height: String?
    var mass: String?
    var hairColor: String?
    var skinColor: String?
    var eyeColor: String?
    var birthYear: String?
    var gender: String?
    var homeworld: String?
    var films: [String]?
    var species: [String]?
    var vehicles: [String]?
    var starships: [String]?
    var url: String?
    
    init(json: [String: Any]) {
        self.name = json[PeopleFields.Name.rawValue] as? String
        self.gender = json[PeopleFields.Gender.rawValue] as? String
        self.homeworld = json[PeopleFields.Homeworld.rawValue] as? String
        self.species = json[PeopleFields.Species.rawValue] as? [String]
        self.films = json[PeopleFields.Films.rawValue] as? [String]
        self.starships = json[PeopleFields.Starships.rawValue] as? [String]
    }
    
    var computedGender: NSMutableAttributedString? {
        if let gender = self.gender {
            return Utils.halfTextColorChange(fullText: "Gender " + String(gender), changeText: "Gender")
        }
        return nil
    }
    
    
    class func endpointForPeople() -> String {
        return "https://swapi.dev/api/people"
    }
    
    class func getPeople(_ completionHandler: @escaping (Result<PeopleWrapper, Error>) -> Void) {
        getPeopleAtPath(People.endpointForPeople(), completionHandler: completionHandler)
    }
    
    private class func getPeopleAtPath(_ path: String, completionHandler: @escaping (Result<PeopleWrapper, Error>) -> Void) {
        // make sure it's HTTPS because sometimes the API gives us HTTP URLs
        let urlData = Utils.checkURL(path)
        
        switch urlData {
        case .success(let url):
            let _ = AF.request(url)
              .responseJSON { response in
                let result = People.peopleArrayFromResponse(response)
                completionHandler(result)
            }
        case .failure(let error):
            completionHandler(.failure(error))
            return
        }
        
    }
    
    private class func peopleArrayFromResponse(_ response: AFDataResponse<Any>) -> Result<PeopleWrapper, Error> {
        
        let dataResponse = Utils.checkAPIResponse(response)
        
        switch dataResponse {
        case .success(let json):
            let wrapper: PeopleWrapper = PeopleWrapper()
            wrapper.next = json["next"] as? String
            wrapper.previous = json["previous"] as? String
            wrapper.count = json["count"] as? Int
          
            var allPeople: [People] = []
            if let results = json["results"] as? [[String: Any]] {
                for jsonPeople in results {
                    let people = People(json: jsonPeople)
                    allPeople.append(people)
                }
            }
            wrapper.results = allPeople
            return .success(wrapper)
        case .failure(let error):
            return .failure(error)
        }
    }

}
