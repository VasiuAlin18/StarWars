//
//  StarWarsManager.swift
//  StarWars
//
//  Created by Take Off Labs on 27.10.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import Alamofire

class StarWarsManager {
    
    
    func fetchPeople() {
        People.getPeople { result in
            switch result {
            case .success(let peopleWrapper):
                self.people = peopleWrapper.results
                self.tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: "Could not load first people :( \(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
