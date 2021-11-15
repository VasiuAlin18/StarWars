//
//  Constants.swift
//  StarWars
//
//  Created by Take Off Labs on 22.10.2021.
//

import UIKit

struct K {
    static let appName = "⚡️StarWars"
    static let peoplePageName = K.appName + " - People"
    static let filmsStarshipsPageName = K.appName + " - Films and Starships"
    static let starshipPageName = K.appName + " - Starship"
    static let speciesPageName = K.appName + " - Species"
    static let homeworldPageName = K.appName + " - Homeworld"
    
    static let registerSegue = "RegisterToLogin"
    static let loginSegue = "LoginToPeople"
    static let peopleNameSegue = "PeopleToDetails"
    static let starshipDetailsSegue = "StarshipToDetails"
    static let peopleSpeciesSegue = "PeopleToSpecies"
    static let planetDetailsSegue = "PlanetToDetails"
    
    static let cellIdentifier = "ReusablePeopleCell"
    static let cellNibName = "PeopleCell"
    
    static let reusableCellIdentifier = "ReusableCellIdentifier"
    static let reusableCellNibName = "ReusableCell"
    
    static let starshipCellIdentifier = "ReusableStarshipCell"
    static let starshipCellNibName = "StarshipCell"
    
    static let avatars: [String: UIImage] = ["Jedi": #imageLiteral(resourceName: "Jedi"), "Sith": #imageLiteral(resourceName: "Sith")]
    
    struct BrandColors {
        static let orange = "BrandOrange"
        static let lightOrange = "BrandLightOrange"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
}
