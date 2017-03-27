//
//  JCDecauxHelper.swift
//  cityBike
//
//  Created by etudiant-09 on 27/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import Foundation

import Foundation
import SwiftyJSON

struct JCDecauxHelper {
    static private let baseEndPoint = "https://api.jcdecaux.com/vls/v1/"
    
    static private let apiKey = "ef94f7064741873b1012c6e2fdeb8664641484c0"
    
    static private let contracts = "contracts"
    
    static private let stations = "stations"
    
    
    private static func getInfoJCDecaux(
        endPoint: String,
        extensionEndPoint: String?,
        parameters: [String: String],
        _ completion : @escaping (JSON) -> Void
        ){
        NetworkManager.sharedInstance.getInfo(
            endPoint: endPoint,
            extensionEndPoint: extensionEndPoint,
            parameters: parameters
            )
        { (json: JSON?, error: Error? ) in
            guard error	== nil else {
                print("error lors de la récuppération des Informations JCDecaux")
                return
            }
            if let json = json {
                //print(json)
                //resultJson = json
                completion(json)
            }
        }
     //   print(resultJson)
     //   return resultJson
    }
    
    static func getContracts(_ completion : @escaping (JSON) -> Void) {
         getInfoJCDecaux(
            endPoint            : params.baseEndPoint,
            extensionEndPoint   : params.contracts,
            parameters          : ["apiKey" : params.apiKey],
            completion
        )


    }
    
    static func getStations(forContract name: String, _ completion : @escaping (JSON) -> Void)  {
        getInfoJCDecaux(
            endPoint            : baseEndPoint,
            extensionEndPoint   : stations,
            parameters          : ["apiKey" : params.apiKey, "contract" : name],
            completion
        )
        
    }
    
    static func getStation(forContract name: String, stationNumber id: Int, _ completion : @escaping (JSON) -> Void) {
        getInfoJCDecaux(
            endPoint: baseEndPoint,
            extensionEndPoint: stations + "/" + String(id),
            parameters: ["apiKey" : params.apiKey, "contract" : name],
            completion
        )
        
    }
    
}
