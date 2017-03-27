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
    
    let country_code : String
    var cities : [String] = []
    let name : String
    let commercial_name : String
    
    init(contract json: JSON) {
        country_code = json["country_code"].stringValue
        for city in json["cities"].arrayObject! {
            if let cityName = city as? String {
                cities.append(cityName)
            }
        }
        name = json["name"].stringValue
        commercial_name = json["commercial_name"].stringValue
        
    }
    
}
