//
//  PeopleManager.swift
//  StarWars
//
//  Created by Take Off Labs on 25.10.2021.
//

import Foundation
import Alamofire

struct PeopleManager {
    
    let peopleURL = "https://swapi.dev/api/people"
    
    
    func fetchPeople() -> [People]? {
        let request = AF.request(peopleURL)
        var people: [People]?
        
//        request.responseDecodable(of: PeopleWrapper.self) { (response) in
//            if response.error != nil {
//                print(response.error!)
//                return
//            }
//            print(response.value)
//            if let peopleWrapper = response.value {
//                people = peopleWrapper.results!
//            }
//        }
        
        return people
    }
    
}
