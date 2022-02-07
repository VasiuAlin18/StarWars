//
//  SpeciesViewController2.swift
//  StarWars
//
//  Created by Take Off Labs on 28.11.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

class SpeciesViewControllerReload: UITableViewController {
    
    var speciesURL: [String]?
    
    var itemArray = ["Find Mike", "Find Eggos", "Destory Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Success!")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpeciesCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
}
