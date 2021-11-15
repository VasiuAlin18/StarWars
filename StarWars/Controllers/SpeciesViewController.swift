//
//  SpeciesViewController.swift
//  StarWars
//
//  Created by Take Off Labs on 31.10.2021.
//

import Foundation
import UIKit

class SpeciesViewController: UIViewController {
    
    @IBOutlet weak var speciesTableView: UITableView!
    
    var speciesURL: [String]?
    
    var species: [Species]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.speciesPageName
        
        speciesTableView.dataSource = self
        
        fetchspecies()
        
        speciesTableView.register(UINib(nibName: K.reusableCellNibName, bundle: nil), forCellReuseIdentifier: K.reusableCellIdentifier)
       
    }
    
}

extension SpeciesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return species?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = speciesTableView.dequeueReusableCell(withIdentifier: K.reusableCellIdentifier, for: indexPath) as! ReusableCell
        
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

extension SpeciesViewController {
    
    func fetchspecies() {

        if let safeSpeciesURL = speciesURL {
            for speciesURL in safeSpeciesURL {
                Species.getPeopleSpecies(speciesURL) { result in
                    switch result {
                    case .success(let film):
                        self.species?.append(film)
                        self.speciesTableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
