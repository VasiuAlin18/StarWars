//
//  Film.swift
//  StarWars
//
//  Created by Take Off Labs on 27.10.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import Alamofire

enum FilmFields: String {
    case Title = "title"
    case EpisodeId = "episode_id"
    case OpeningCrawl = "opening_crawl"
    case Director = "director"
    case Producer = "producer"
    case ReleaseDate = "release_date"
    case Characters = "characters"
    case Planets = "planets"
    case Starships = "starships"
    case Vehicles = "vehicles"
    case Species = "species"
    case Url = "url"
}

class Film {
    var idNumber: Int?
    var title: String?
    var episodeId: Int?
    var openingCrawl: String?
    var director: String?
    var producer: String?
    var releaseDate: String?
    var characters: [String]?
    var planets: [String]?
    var starships: [String]?
    var vehicles: [String]?
    var species: [String]?
    var url: String?
    
    var computedTitle: NSMutableAttributedString? {
        if let title = self.title {
            return Utils.halfTextColorChange(fullText: "Title " + String(title), changeText: "Title")
        }
        return nil
    }
    
    var computedEpisodeId: NSMutableAttributedString? {
        if let epId = episodeId {
            return Utils.halfTextColorChange(fullText: "Episode " + String(epId), changeText: "Episode")
        }
        return nil
    }
    
    var computedDirector: NSMutableAttributedString? {
        if let dir = director {
            return Utils.halfTextColorChange(fullText: "Director " + dir, changeText: "Director")
        }
        return nil
    }
    
    var computedReleaseDate: NSMutableAttributedString? {
        if let rDate = releaseDate {
            return Utils.halfTextColorChange(fullText: "Release Date " + rDate, changeText: "Release Date")
        }
        return nil
    }
    
    init(json: [String: Any]){
        self.title = json[FilmFields.Title.rawValue] as? String
        self.director = json[FilmFields.Director.rawValue] as? String
        self.releaseDate = json[FilmFields.ReleaseDate.rawValue] as? String
        self.episodeId = json[FilmFields.EpisodeId.rawValue] as? Int
    }
    
    class func endpointForFilmId(_ id: Int) -> String {
        return "https://swapi.dev/api/films/\(id)"
    }
    
    class func getPeopleFilms(_ path: String, _ completionHandler: @escaping (Result<Film, Error>) -> Void) {
        getFilmAtPath(path, completionHandler: completionHandler)
    }
    
    private class func getFilmAtPath(_ path: String, completionHandler: @escaping (Result<Film, Error>) -> Void) {
        
        let urlData = Utils.checkURL(path)
        
        switch urlData {
        case .success(let url):
            let _ = AF.request(url).responseJSON { response in
                let result = Film.filmFromResponse(response)
                completionHandler(result)
            }
        case .failure(let error):
            completionHandler(.failure(error))
            return
        }
        
    }
    
    private class func filmFromResponse(_ response: AFDataResponse<Any>) -> Result<Film, Error> {
        
        let dataResponse = Utils.checkAPIResponse(response)
        
        switch dataResponse {
        case .success(let json):
            let film = Film(json: json)
            return .success(film)
        case .failure(let error):
            return .failure(error)
        }
        
    }
    
}


