//
//  CityViewController.swift
//  cityBike
//
//  Created by etudiant-09 on 27/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import UIKit
import CoreLocation

class CityViewController: UIViewController, StationListProvider, ContractConsumer {
    
    var allStations : [Station] = [] {
        didSet {
            self.nbStationLabel.text = String(allStations.count)
        }
    }
    
    var city : String? {
        didSet {
            self.cityLabel.text = city
        }
    }
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var nbStationLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadStations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "cityToMapView") {
            if let destinationVC = segue.destination as? MapCityViewController {
                destinationVC.stations = self.allStations
                destinationVC.city = self.city
            }
        }
        
    }
    
    
    
    
    @IBAction func HomeButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "cityToMapView", sender: self)
    }
    
    
    
    private func loadStations() {
        self.allStations.removeAll()
        if self.city != nil {
            JCDecauxHelper.getStations(forContract: self.city!) {
                json in
                for stationJson in json.arrayValue {
                    self.allStations.append(Station(stationJson))
                }
                
            }
        }
    }
    
    // -MARK: StationListProvider Implementation
    
    func getStationList() -> [Station]? {
        return self.allStations
    }
    
    func getUserLocation() -> CLLocation? {
        return nil
    }
    
    func setCityContract(_ city: String?) {
        print("Contract Consumer. City recieved : \(city)")
        self.city = city
    }
}
