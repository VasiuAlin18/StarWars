//
//  SpeciesViewControllerBetter.swift
//  StarWars
//
//  Created by Take Off Labs on 28.11.2021.
//

import Foundation
import UIKit

class SpeciesViewControllerBetter: UITableViewController {
    
    var speciesURL: [String]?
    
    var species: [Species]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(named: K.BrandColors.orange)
        
        title = K.speciesPageName
        
        fetchspecies()
        
        tableView.register(UINib(nibName: K.reusableCellNibName, bundle: nil), forCellReuseIdentifier: K.reusableCellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return species?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCellIdentifier, for: indexPath) as! ReusableCell
        
        if species != nil {
            let currentData = self.species?[indexPath.row]
            
            cell.item1Label.text = currentData?.name
            cell.item2Label.attributedText = currentData?.computedClassification
            cell.item3Label.attributedText = currentData?.computedDesignation
            cell.item4Label.attributedText = currentData?.computedAverageHeight
        }
        
        return cell
    }
    
}

extension SpeciesViewControllerBetter {
    
    func fetchspecies() {

        if let safeSpeciesURL = speciesURL {
            for speciesURL in safeSpeciesURL {
                Species.getPeopleSpecies(speciesURL) { result in
                    switch result {
                    case .success(let film):
                        self.species?.append(film)
                        self.tableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

