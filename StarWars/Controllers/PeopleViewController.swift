//
//  PeopleViewController.swift
//  StarWars
//
//  Created by Take Off Labs on 22.10.2021.
//

import UIKit
import Firebase
import Alamofire

class PeopleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    let user = Auth.auth().currentUser
    
    var people: [People]?
    
    var selectedWarriorName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.peoplePageName
        
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchPeople()
        
        if let loggedUser = user {
            let avatar = UserDefaults.standard.object(forKey: loggedUser.email ?? "") as! String
            avatarImage.image = K.avatars[avatar]
        }
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }

    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.people == nil {
            return 0
        }
        return self.people!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! PeopleCell
        
        cell.delegate = self
        
        if self.people != nil {
            let warrior = self.people![indexPath.row]
            cell.warriorNameButton.setTitle(warrior.name, for: .normal)
            cell.warriorGenderLabel.attributedText = warrior.computedGender
            cell.warriorHomeworldButton.setTitle("Homeworld", for: .normal)
            cell.warriorSpeciesButton.setTitle("Species", for: .normal)
        }
        
        return cell
    }
    
}

extension PeopleViewController: PeopleCellDelegate {
    func didPressedHomeworldButton(peopleCell: PeopleCell, selectedWarrioName: String) {
        self.selectedWarriorName = selectedWarrioName
        self.performSegue(withIdentifier: K.planetDetailsSegue, sender: self)
    }
    
    func didPressedSpeciesButton(peopleCell: PeopleCell, selectedWarriorName: String) {
        self.selectedWarriorName = selectedWarriorName
        self.performSegue(withIdentifier: K.peopleSpeciesSegue, sender: self)
    }
    
    func didPressedNameButton(peopleCell: PeopleCell, selectedWarriorName: String) {
        self.selectedWarriorName = selectedWarriorName
        self.performSegue(withIdentifier: K.peopleNameSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let findPeople = people?.first(where: {$0.name == self.selectedWarriorName})
        
        if segue.identifier == K.peopleNameSegue {
            let destinationVC = segue.destination as! FilmsStarshipsViewController
            
            destinationVC.filmsURL = findPeople?.films
            destinationVC.starshipsURL = findPeople?.starships
        } else if segue.identifier == K.peopleSpeciesSegue {
            let destinationVC = segue.destination as! SpeciesViewController
            
            destinationVC.speciesURL = findPeople?.species
        } else if segue.identifier == K.planetDetailsSegue {
            let destinationVC = segue.destination as! PlanetViewController
            
            destinationVC.planetURL = findPeople?.homeworld
        }
    }
}

extension PeopleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension PeopleViewController {
    
    func fetchPeople() {

        People.getPeople { result in
            switch result {
            case .success(let peopleWrapper):
                self.people = peopleWrapper.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: "Could not load first people :( \(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

    }
    
//    Alamofire with decodable
//    func fetchPeople() {
//        AF.request("https://swapi.dev/api/people").validate().responseDecodable(of: PeopleWrapper.self) { (response) in
//            if response.error != nil {
//                let alert = UIAlertController(title: "Error", message: "Could not load first people :( \(response.error!.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//
//            guard let peopleWrapper = response.value else { return }
//            self.people = peopleWrapper.results
//            print(self.people?[0].name)
//            print(self.people?[0].height)
//            self.tableView.reloadData()
//        }
//    }
    
}

