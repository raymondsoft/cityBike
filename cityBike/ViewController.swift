//
//  ViewController.swift
//  cityBike
//
//  Created by etudiant-09 on 27/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(_ animated: Bool) {
// TEST
        /*
        JCDecauxHelper.getContracts(){
            json in
            for contractJson in json.arrayValue {
                let contract = Contract(contract: contractJson)
                print(contract)
                
            }
        }
        */
        /*
        JCDecauxHelper.getStations(forContract: "Paris") {
            
            json in
            for stationJson in json.arrayValue {
                let station = Station(stationJson)
                print(station)
            }
            //print(json)
        }
        */
        JCDecauxHelper.getStation(forContract: "Paris", stationNumber: 31705) {
            json in
                let station = Station(json)
                print(station)
            
            //print(json)
        }
        
        
        print(Date(timeIntervalSince1970: 1490614263.0))
        print(Date())
        
        /*
        if let contractsJson = JCDecauxHelper.getContracts() {
            for json in contractsJson.arrayValue {
                let contract = Contract(contract: json)
                print(contract)
            }
        }
*/
// FIN TESTS
    }
    
    

}

