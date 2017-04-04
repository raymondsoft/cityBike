//
//  Station.swift
//  cityBike
//
//  Created by etudiant-09 on 27/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation
/*
 {
 "bonus" : false,
 "status" : "OPEN",
 "position" : {
 "lat" : 48.87242997325711,
 "lng" : 2.355489390173873
 },
 "available_bikes" : 3,
 "available_bike_stands" : 15,
 "bike_stands" : 19,
 "address" : "57 RUE DU CHATEAU D'EAU - 75010 PARIS",
 "last_update" : 1490613042000,
 "number" : 10007,
 "contract_name" : "Paris",
 "name" : "10007 - CHATEAU D'EAU",
 "banking" : true
 }
 
 */

class Station {
    let bonus : Bool
    let isOpen : Bool
    let latitude : Double
    let longitude : Double
    let availableBikes : Int
    let availableBikeStands : Int
    let bikeStands : Int
    let address : String
    let lastUpdate : Date
    let number : Int
    let contractName : String
    let name : String
    let banking : Bool
    let favourite : Bool = false
    
    var distanceToUser : Double? = nil
    
    var availableBikeColor : UIColor
    var availableStandColor : UIColor
    
    var type : StationType = .standard
    
    
    init(_ json: JSON) {
        bonus = json["bonus"].boolValue
        isOpen = json["status"].stringValue == "OPEN"
        latitude = json["position"]["lat"].doubleValue
        longitude = json["position"]["lng"].doubleValue
        availableBikes = json["available_bikes"].intValue
        availableBikeStands = json["available_bike_stands"].intValue
        bikeStands = json["bike_stands"].intValue
        address = json["address"].stringValue
        
        //last update is in ms. We want seconds
        lastUpdate = Date(timeIntervalSince1970: json["last_update"].doubleValue / 1000)
        
        number = json["number"].intValue
        contractName = json["contract_name"].stringValue
        name = json["name"].stringValue.trimBefore("-")
        banking = json["banking"].boolValue
        
        self.availableBikeColor = Station.getAvailableColor(availableItem: availableBikes, totalBikesStand: bikeStands)
        self.availableStandColor = Station.getAvailableColor(availableItem: availableBikeStands, totalBikesStand: bikeStands)
    }
    
    func setType(_ type : StationType) {
        self.type = type
    }
    
    func setDistanceToUser(location: CLLocation) {
        let position = CLLocation(latitude: self.latitude, longitude: self.longitude)
        self.distanceToUser = position.distance(from: location)
    }
    
    
    
    private static func getAvailableColor(availableItem: Int, totalBikesStand: Int) -> UIColor {
        let percentage = Float(availableItem) / Float(totalBikesStand)
        var red : Float = 1
        var green : Float = 1
        var blue : Float = 1
        let alpha : Float = 1
        
        switch percentage {
        case 0..<0.25:
            red = 1
            green = percentage * 2.0
            blue = 0
        case 0.25...0.5:
            red = -4 * percentage + 2
            green = percentage * 2.0
            blue = 0
            
        default:
            red = 0
            green = 1
            blue = 0
        }
        
        return UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
    }
    /*
    private func setAvailableStandsColor() {
        let percentage = Float(self.availableBikeStands) / Float(self.bikeStands)
        var red : Float = 1
        var green : Float = 1
        var blue : Float = 1
        let alpha : Float = 1
        
        switch percentage {
        case 0..<0.25:
            red = 1
            green = percentage * 2.0
            blue = 0
        case 0.25...0.5:
            red = -4 * percentage + 2
            green = percentage * 2.0
            blue = 0
            
        default:
            red = 0
            green = 1
            blue = 0
        }
        self.availableStandColor = UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
    }
    */

    
}




enum StationType : String {
    
    case standard = "stdId"
    
    case favorite = "favId"
    
    case home = "homeId"
    
    case work = "workId"
}



