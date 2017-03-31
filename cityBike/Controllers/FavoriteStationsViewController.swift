//
//  FavoriteStationsViewController.swift
//  cityBike
//
//  Created by etudiant-09 on 30/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import UIKit

class FavoriteStationsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var screenType: ScreenType!
    
    var city: String!
    
    var stations : [Station]!
    
    var favoriteStationsIds : [Int]?

    @IBOutlet weak var screenTypeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    override func viewWillAppear(_ animated: Bool) {
        self.city = "Nantes"
        self.screenTypeLabel.text = self.screenType.description
        self.view.backgroundColor = self.screenType.color
        
        loadFavoritesStations()
        
        // favoriteStationsIds is nil with the geoloc type.
        if self.favoriteStationsIds != nil {
            self.stations = self.stations.filter({self.favoriteStationsIds!.contains($0.number)})
        }
     
        print("Noms des stations :")
        if let stations = self.stations {
            for station in stations {
                print("\(station.name)")
            }
        }
        
        
        self.tableView.reloadData()
 
//        print("Stations \(self.screenType.description) :")
//        for station in stations {
//            if (self.favoriteStationsIds?.contains(station.number))!{
//                print(station.name)
//            }
//        }
        
    }
    
    private func loadFavoritesStations() {
        if let favoriteIds = PersistanceManager.getFavoriteIds(for: self.screenType.userDefaultsKey){
            self.favoriteStationsIds = favoriteIds
        }
    }
    
    /*
    private func loadStations() {
        self.stations?.removeAll()
        var tempStation = [Station]()
        JCDecauxHelper.getStations(forContract: self.city) {
            json in
            for stationJson in json.arrayValue {
                tempStation.append(Station(stationJson))
            }
            
            print(tempStation.count)
            
        }
        self.stations = tempStation
    }
 */
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    // -MARK: tableView DELEGATE
    
    
    // -MARK: TableView DATASOURCE
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.stations != nil {
            return self.stations.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stationCell = self.tableView.dequeueReusableCell(withIdentifier: "StationCell") as? StationTableViewCell
        stationCell?.buildFrom(station: self.stations[indexPath.row])
        print("stationCell built from \(stations[indexPath.row].name)")
        
        return stationCell!
    }
    
}
