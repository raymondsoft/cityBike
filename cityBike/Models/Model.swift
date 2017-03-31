//
//  Model.swift
//  cityBike
//
//  Created by etudiant-09 on 29/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import Foundation
import UIKit


enum ScreenType {
    case home
    case work
    case favorite
    case geoloc
    
    var description: String {
        switch self {
        case .home:
            return "Home"
        case .work:
            return "Work"
        case .geoloc:
            return "Geolocalisation"
        case .favorite:
            return "Favorite"
        }
    }
    
    var imageName: String {
        switch self {
        case .home:
            return "home"
        case .work:
            return "work"
        case .geoloc:
            return "geoloc"
        case .favorite :
            return "favorite"
        }
    }
    
    // clé utilisée pour la persistance sur UserDefaults
    var userDefaultsKey: String {
        switch self {
        case .home :
            return "homeId"
        case .work :
            return "workId"
        case .geoloc :
            return "geolocStations"
        case .favorite :
            return "favId"
        }
    }
    
    var color: UIColor {
        switch self {
        case .favorite:
            return UIColor.red
        case .geoloc:
            return UIColor.green
        case .home:
            return UIColor.blue
        case .work:
            return UIColor.cyan
        }
    }
    
    var stationType: StationType {
        switch self {
        case .favorite:
            return .favorite
        case .geoloc:
            return .standard
        case .home:
            return .home
        case .work:
            return .work
        }
    }
    
}
