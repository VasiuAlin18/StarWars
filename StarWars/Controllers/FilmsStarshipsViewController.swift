//
//  FilmsStarshipsViewController.swift
//  StarWars
//
//  Created by Take Off Labs on 27.10.2021.
//

import Foundation
import UIKit

class FilmsStarshipsViewController: UIViewController {
    
    @IBOutlet weak var filmsTableView: UITableView!
    @IBOutlet weak var speciesTableView: UITableView!
    
    var filmsURL: [String]?
    var starshipsURL: [String]?
    
    var films: [Film]? = []
    var starships: [Starship]? = []
    
    var selectedStarshipName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.filmsStarshipsPageName
        
        filmsTableView.dataSource = self
        speciesTableView.dataSource = self
        
        fetchFilms()
        fetchStarships()
        
        
        filmsTableView.register(UINib(nibName: K.reusableCellNibName, bundle: nil), forCellReuseIdentifier: K.reusableCellIdentifier)
        speciesTableView.register(UINib(nibName: K.starshipCellNibName, bundle: nil), forCellReuseIdentifier: K.starshipCellIdentifier)
        
    }

}

extension FilmsStarshipsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.filmsTableView {
            return films?.count ?? 0
        } else {
            return starships?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.filmsTableView {
            let cell = filmsTableView.dequeueReusableCell(withIdentifier: K.reusableCellIdentifier, for: indexPath) as! ReusableCell
            
            if films != nil {
                let currentFilm = self.films?[indexPath.row]
                
                cell.item1Label.attributedText = currentFilm?.computedTitle
                cell.item2Label.attributedText = currentFilm?.computedDirector
                cell.item3Label.attributedText = currentFilm?.computedEpisodeId
                cell.item4Label.attributedText = currentFilm?.computedReleaseDate
            }
            
            return cell
        } else {
            let cell = speciesTableView.dequeueReusableCell(withIdentifier: K.starshipCellIdentifier, for: indexPath) as! StarshipCell
            
            cell.delegate = self
            
            if starships != nil {
                let currentStarship = self.starships?[indexPath.row]
                
                cell.starshipNameButton.setAttributedTitle(currentStarship?.computedName, for: .normal)
                cell.starshipModelLabel.attributedText = currentStarship?.computedModel
            }
            
            return cell
        }
        
    }
    
}

extension FilmsStarshipsViewController: StarshipCellDelegate {
    
    func didPressedStarshipNameButton(starshipCell: StarshipCell, selectedStarshipName: String) {
        var starshipName = selectedStarshipName
        
        let range = starshipName.startIndex..<starshipName.index(starshipName.startIndex, offsetBy: 9)
        starshipName.removeSubrange(range)
        self.selectedStarshipName = starshipName
        
        
        self.performSegue(withIdentifier: K.starshipDetailsSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! StarshipViewController
        
        let findStarship = starships?.first(where: {$0.name == self.selectedStarshipName})
        
        destinationVC.starship = findStarship
    }
    
    
}

extension FilmsStarshipsViewController {
    
    func fetchFilms() {

        if let safeFilmsURL = filmsURL {
            for filmURL in safeFilmsURL {
                Film.getPeopleFilms(filmURL) { result in
                    switch result {
                    case .success(let film):
                        self.films?.append(film)
                        DispatchQueue.main.async {
                            self.filmsTableView.reloadData()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func fetchStarships() {

        if let safeStarshipsURL = starshipsURL {
            for starshipURL in safeStarshipsURL {
                Starship.getPeopleStarships(starshipURL) { result in
                    switch result {
                    case .success(let starship):
                        self.starships?.append(starship)
                        DispatchQueue.main.async {
                            self.speciesTableView.reloadData()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
}
