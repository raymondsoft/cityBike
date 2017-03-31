//
//  CityViewController.swift
//  cityBike
//
//  Created by etudiant-09 on 27/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import UIKit

class CityViewController: UIViewController, StationListProvider {
    
    var allStations : [Station] = [] {
        didSet {
            self.nbStationLabel.text = String(allStations.count)
        }
    }
    
    var city = "" {
        didSet {
            self.cityLabel.text = city
        }
    }
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var nbStationLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.city = "Nantes"
        loadStations()
        
        // Do any additional setup after loading the view.
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
        JCDecauxHelper.getStations(forContract: self.city) {
            json in
            for stationJson in json.arrayValue {
                self.allStations.append(Station(stationJson))
            }
            
        }
    }
    
    // -MARK: StationListProvider Implementation
    
    func getStationList() -> [Station]? {
        return self.allStations
    }
    
}
