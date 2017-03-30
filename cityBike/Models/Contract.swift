//
//  Contract.swift
//  cityBike
//
//  Created by etudiant-09 on 27/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import Foundation
import SwiftyJSON

/*
 
 {
 "country_code" : "FR",
 "cities" : [
 "Rouen"
 ],
 "name" : "Rouen",
 "commercial_name" : "cy'clic"
 }
 
 */



struct Contract {
    
    let countryCode : String
    var cities : [String] = []
    let name : String
    let commercialName : String
    
    init(contract json: JSON) {
        countryCode = json["country_code"].stringValue
        for city in json["cities"].arrayObject! {
            if let cityName = city as? String {
                cities.append(cityName)
            }
        }
        name = json["name"].stringValue
        commercialName = json["commercial_name"].stringValue
        
    }
    
}
