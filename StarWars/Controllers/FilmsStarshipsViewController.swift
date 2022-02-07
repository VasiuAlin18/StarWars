//
//  FilmsStarshipsViewController.swift
//  StarWars
//
//  Created by Take Off Labs on 27.10.2021.
//

import Foundation
import UIKit
import CoreData

class FilmsStarshipsViewController: UIViewController {
    
    @IBOutlet weak var filmsTableView: UITableView!
    @IBOutlet weak var starshipsTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var filmsURL: [String]?
    var starshipsURL: [String]?
    
    var films: [Film]? = []
    var starships: [StarshipModel]? = []
    var starships_api: [StarshipModel]? = []
    
    var selectedStarshipName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.filmsStarshipsPageName
        
        filmsTableView.dataSource = self
        starshipsTableView.dataSource = self
        
        fetchFilms()
//        loadStarships()
//        saveItems()
//        searchStarship(starshipURL: "https://swapi.dev/api/starships/22/")
//        deleteStarship(starshipURL: "https://swapi.dev/api/starships/12/")
//        loadStarships()
        loadStarships2()
//        fetchStarships()
        
        
        filmsTableView.register(UINib(nibName: K.reusableCellNibName, bundle: nil), forCellReuseIdentifier: K.reusableCellIdentifier)
        starshipsTableView.register(UINib(nibName: K.starshipCellNibName, bundle: nil), forCellReuseIdentifier: K.starshipCellIdentifier)
        
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
            let cell = starshipsTableView.dequeueReusableCell(withIdentifier: K.starshipCellIdentifier, for: indexPath) as! StarshipCell
            
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
    
    func loadStarships2(from_db: Bool = false) {
        if let safeStarshipsURL = starshipsURL {
            let request: NSFetchRequest<StarshipModel> = StarshipModel.fetchRequest()
            
            request.predicate = NSPredicate(format: "url IN %@", safeStarshipsURL)
            
            request.sortDescriptors = []
            
            do {
                let starships = try context.fetch(request)
                if from_db || (!from_db && starships.count == safeStarshipsURL.count) {
                    print("Data from DB")
                    self.starships = starships
                    self.starshipsTableView.reloadData()
                } else {
                    print("Call API")
                    fetchStarships()
                }
            } catch {
                print("Erorr fetching data from context \(error)")
            }
        }
    }
    
    func fetchStarships() {
        var starships: [StarshipModel] = []
        if let safeStarshipsURL = starshipsURL {
            for starshipURL in safeStarshipsURL {
                StarshipModel.getPeopleStarships(starshipURL) { result in
                    switch result {
                    case .success(let starship):
                        self.starships_api?.append(starship)
                        self.saveItems()
                        self.loadStarships2(from_db: true)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func saveItems() {
//        let newStarship = StarshipModel(context: self.context)
//        newStarship.name = "Imperial shuttle"
//        newStarship.model = "Lambda-class T-4a shuttle"
//        newStarship.starshipClass = "Armed government transport"
//        newStarship.manufacturer = "Sienar Fleet Systems"
//        newStarship.length = "20"
//        newStarship.crew = "6"
//        newStarship.url = "https://swapi.dev/api/starships/22/"
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func deleteStarship(starshipURL: String) {
        let request: NSFetchRequest<StarshipModel> = StarshipModel.fetchRequest()
        
        request.predicate = NSPredicate(format: "url CONTAINS %@", starshipURL)
        
        request.sortDescriptors = []
        
        do {
            let starships = try context.fetch(request)
            if starships.count > 0 {
                context.delete(starships[0])
                saveItems()
            }
        } catch {
            print("Erorr fetching data from context \(error)")
        }
    }
    
    func loadStarships() {

        if let safeStarshipsURL = starshipsURL {
            for starshipURL in safeStarshipsURL {
                if let starship = searchStarship(starshipURL: starshipURL) {
                    print("Starship Exist \(starship.name)")
                    self.starships?.append(starship)
                    self.starshipsTableView.reloadData()
                }
            }
        }
    }
    
    func searchStarship(starshipURL: String) -> StarshipModel? {
        var starship = StarshipModel(context: self.context)
        
        let request: NSFetchRequest<StarshipModel> = StarshipModel.fetchRequest()
        
        request.predicate = NSPredicate(format: "url CONTAINS %@", starshipURL)
        
        request.sortDescriptors = []
        
        do {
            let starships = try context.fetch(request)
            if starships.count > 0 {
                starship = starships[0]
            } else {
                print("No starship for url \(starshipURL)")
                self.starships = []
                self.starshipsTableView.reloadData()
//                fetchStarships()
            }
        } catch {
            print("Erorr fetching data from context \(error)")
        }
        
        return starship
    }
    
}
