//
//  StarshipModel+CoreDataProperties.swift
//  StarWars
//
//  Created by Take Off Labs on 01.02.2022.
//
//

import Foundation
import CoreData
import Alamofire


extension StarshipModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StarshipModel> {
        return NSFetchRequest<StarshipModel>(entityName: "StarshipModel")
    }

    @NSManaged public var name: String?
    @NSManaged public var model: String?
    @NSManaged public var starshipClass: String?
    @NSManaged public var manufacturer: String?
    @NSManaged public var length: String?
    @NSManaged public var crew: String?
    @NSManaged public var url: String?
    
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
    
    class func getPeopleStarships(_ path: String, completionHandler: @escaping (Result<StarshipModel, Error>) -> Void) {
        getStarshipAtPath(path, completionHandler: completionHandler)
    }
    
    private class func getStarshipAtPath(_ path: String, completionHandler: @escaping (Result<StarshipModel, Error>) -> Void) {
        
        let urlData = Utils.checkURL(path)
        
        switch urlData {
        case .success(let url):
            let _ = AF.request(url).responseJSON { response in
                let result = StarshipModel.starshipFromResponse(response)
                completionHandler(result)
            }
        case .failure(let error):
            completionHandler(.failure(error))
            return
        }
        
    }
    
    private class func starshipFromResponse(_ response: AFDataResponse<Any>) -> Result<StarshipModel, Error> {
        
        let dataResponse = Utils.checkAPIResponse(response)
        
        switch dataResponse {
        case .success(let json):
            let starship = init_data(json: json)
            print("Getting one starship from API...")
            return .success(starship)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private class func init_data(json: [String: Any]) -> StarshipModel{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let starship = StarshipModel(context: context)
        starship.name = json[StarshipFields.Name.rawValue] as? String
        starship.model = json[StarshipFields.Model.rawValue] as? String
        starship.starshipClass = json[StarshipFields.StarshipClass.rawValue] as? String
        starship.manufacturer = json[StarshipFields.Manufacturer.rawValue] as? String
        starship.length = json[StarshipFields.Length.rawValue] as? String
        starship.crew = json[StarshipFields.Crew.rawValue] as? String
        starship.url = json[StarshipFields.Url.rawValue] as? String
        
        return starship
    }

}
