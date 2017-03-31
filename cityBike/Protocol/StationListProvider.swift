//
//  StationListProvider.swift
//  cityBike
//
//  Created by etudiant-09 on 30/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import Foundation

protocol StationListProvider {
    func getStationList() -> [Station]?
}
