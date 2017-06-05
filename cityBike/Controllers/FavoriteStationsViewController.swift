//
//  FavoriteStationsViewController.swift
//  cityBike
//
//  Created by etudiant-09 on 30/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import UIKit
import CoreLocation

class FavoriteStationsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, ContractConsumer {
    
    var screenType: ScreenType!
    
    var city: String!
    
    var stations : [Station]! {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var favoriteStationsIds : [Int]?
    
    
    var userPosition : CLLocation?{
        didSet {
            print("USER LOCATION UPDATED")
            print("\t oldValue: (\(String(describing: oldValue?.coordinate.latitude)) , \(String(describing: oldValue?.coordinate.longitude)))")
            print("\t newValue: (\(String(describing: userPosition?.coordinate.latitude)) , \(String(describing: userPosition?.coordinate.longitude)))")
            self.sortStationsByDistanceToUser()
        }
    }
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var screenTypeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.initUserLocation()
        
        self.refreshDatas()
        //        self.filterStations()
        
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshDatas), for: UIControlEvents.valueChanged)
        
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
        self.screenTypeLabel.text = self.screenType.description
        self.view.backgroundColor = self.screenType.color
        self.refreshDatas()
        
    }
    
    private func filterStations() {
        
        loadFavoritesStations()
        
        if self.favoriteStationsIds != nil {
            self.stations = self.stations.filter({self.favoriteStationsIds!.contains($0.number)})
        }
        
        self.sortStationsByDistanceToUser()
    }
    
    
    private func loadFavoritesStations() {
        if self.screenType != ScreenType.geoloc {
            if let favoriteIds = PersistanceManager.getFavoriteIds(for: self.screenType.userDefaultsKey, contract: self.city){
                self.favoriteStationsIds = favoriteIds
            }
        } else {
            self.loadNearestStations()
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
    
    
    // If the user position is not set, we don't sort the stations
    private func sortStationsByDistanceToUser() {
        if let userPosition = self.userPosition {
            if (self.stations != nil) {
                for station in self.stations {
                    station.setDistanceToUser(location: userPosition)
                }
                self.stations.sort(by: {$0.distanceToUser! < $1.distanceToUser!})
            }
        }
    }
    
    
    func loadNearestStations() {
        self.favoriteStationsIds = self.stations.map({$0.number})
    }
    
    // -MARK: User Position Management
    
    func initUserLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
        //        locationManager.requestWhenInUseAuthorization()
        //        locationManager.startUpdatingLocation()
    }
    
    
    // -MARK: CLLocationMananger DELEGATE
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userPosition = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while getting userLocation")
        self.userPosition = nil
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
        
        return stationCell!
    }
    
    
    
    func refreshDatas(){
        if(self.city != nil) {
            JCDecauxHelper.getStations(forContract: self.city!){
                json in
                self.initUserLocation()
                var tempStations = [Station]()
                for stationJson in json.arrayValue {
                    tempStations.append(Station(stationJson))
                }
                self.stations = tempStations
                self.filterStations()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
        
    }
    
    func setCityContract(_ city: String?) {
        print("Contract Consumer. City recieved : \(String(describing: city))")
        self.city = city
    }
    
}
