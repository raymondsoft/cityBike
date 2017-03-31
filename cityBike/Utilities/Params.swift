//
//  Params.swift
//  cityBike
//
//  Created by etudiant-09 on 27/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import Foundation
import SwiftyJSON

struct params {
    static let baseEndPoint = "https://api.jcdecaux.com/vls/v1/"
    
    static let apiKey = "ef94f7064741873b1012c6e2fdeb8664641484c0"
    
    static let contracts = "contracts"
    
    static let stations = "stations"
    
    static let favoriteId = "favId"
    
    static let homeId = "homeId"
    
    static let workId = "workId"
    
    
    private static func getInfoJCDecaux(endPoint: String, extensionEndPoint: String?,  parameters: [String: String]) -> JSON? {
        var resultJson : JSON?
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
                resultJson = json
            }
        }
        return resultJson
    }
    
    static func getContracts() -> JSON? {
        return getInfoJCDecaux(
            endPoint: params.baseEndPoint,
            extensionEndPoint: params.contracts,
            parameters: ["apiKey" : params.apiKey]
        )
    }
    
    static func getStations(forContract: String) -> JSON? {
        return getInfoJCDecaux(endPoint: baseEndPoint, extensionEndPoint: stations, parameters: ["apiKey" : params.apiKey, "contract" : forContract])
    }
    
}
