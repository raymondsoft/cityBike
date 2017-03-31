//
//  MapCityViewController.swift
//  cityBike
//
//  Created by etudiant-09 on 27/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapCityViewController: UIViewController, MKMapViewDelegate, StationMapViewDelegate, StationListProvider {
    
    var stations : [Station]?
    
    // -TODO: Vérifier si 'city' est utile !
    var city : String?
    
    var selectedStation : Station!
    
    let locationManager = CLLocationManager()
    
    var favouritesStationsId = [Int]()
    var workStationsId = [Int]()
    var homeStationsId = [Int]()
    
    @IBOutlet weak var debugLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var standsSegmentedControl: UISegmentedControl!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestLocationAccess()
        let newlocation = CLLocation(latitude: (self.stations?.first?.latitude)!, longitude: (self.stations?.first?.longitude)!)
        centerView(at: newlocation, radius: 0.04)
        //  self.locationManager.delegate = self
        self.mapView.delegate = self
        
        mapView.showsUserLocation = true
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveInfo), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveInfo() {
//        PersistanceManager.deleteChosenIds()
//        PersistanceManager.saveFavoritesIds(stationIds: self.favouritesStationsId)
        
        PersistanceManager.deleteChosenIds(for: StationType.favorite.rawValue)
        PersistanceManager.deleteChosenIds(for: StationType.home.rawValue)
        PersistanceManager.deleteChosenIds(for: StationType.work.rawValue)
        
        PersistanceManager.saveStationsId(for: StationType.favorite.rawValue, with: self.favouritesStationsId)
        PersistanceManager.saveStationsId(for: StationType.home.rawValue, with: self.homeStationsId)
        PersistanceManager.saveStationsId(for: StationType.work.rawValue, with: self.workStationsId)
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if (segue.identifier == "openStationPopOver") {
    //            if let destinationVC = segue.destination as? StationDetailViewController {
    //                destinationVC.station = self.selectedStation
    //            }
    //        }
    //     // Get the new view controller using segue.destinationViewController.
    //     // Pass the selected object to the new view controller.
    //     }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.debugLabel.text = "nb stations : \(self.stations!.count) et ville : \(self.city!)"

        if let favoriteId = PersistanceManager.getFavoriteIds(for: StationType.favorite.rawValue){
            self.favouritesStationsId = favoriteId
        }
        if let homeId = PersistanceManager.getFavoriteIds(for: StationType.home.rawValue){
            self.homeStationsId = homeId
        }
        if let workId = PersistanceManager.getFavoriteIds(for: StationType.work.rawValue){
            self.workStationsId = workId
        }
        
        addAllStationAnnotations()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.saveInfo()
    }
    
    func addAllStationAnnotations() {
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        if let stations = self.stations {
            for station in stations {
                addStationAnnotation(from: station)
            }
        }
    }
    
    func addStationAnnotation(from station: Station){
        let stationAnnotation = StationAnnotation()

        let type = userStationAnnotationType(from: station)
        stationAnnotation.buildAnnotationFromStation(station, type: type)
        
        self.mapView.addAnnotation(stationAnnotation)
    }
    
    func userStationAnnotationType(from station: Station) -> StationType {
        let stationId = station.number
        var type = StationType.standard
        if (self.favouritesStationsId.contains(stationId))  { type = .favorite }
        if (self.workStationsId.contains(stationId))        { type = .work }
        if (self.homeStationsId.contains(stationId))        { type = .home }
        
        return type
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    // -MARK: MKMapViewDelegates functions
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        } else {
            if let stationAnnotation = annotation as? StationAnnotation {
                let pinAnnotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "cityBikeAnnotationView") as? StationAnnotationView ?? StationAnnotationView(annotation: annotation, reuseIdentifier: "cityBikeAnnotationView")
                pinAnnotationView.stationDelegate = self

                pinAnnotationView.annotation = stationAnnotation
                for subview in pinAnnotationView.subviews {
                    subview.removeFromSuperview()
                }
                
                
                switch stationAnnotation.station!.type {
                case .standard:
                    pinAnnotationView.image = #imageLiteral(resourceName: "station_grise")
                case .favorite:
                    pinAnnotationView.image = #imageLiteral(resourceName: "fleche_pleine")
                case .home:
                    pinAnnotationView.image = #imageLiteral(resourceName: "home")
                case .work:
                    pinAnnotationView.image = #imageLiteral(resourceName: "work")
                }
                
                pinAnnotationView.image = Utilities.resizeImage(image: pinAnnotationView.image!, newWidth: 30.0)
                var availableLabelNumber : Int
                let pinColor : UIColor
                if(standsSegmentedControl.selectedSegmentIndex == 0) {
                    availableLabelNumber = stationAnnotation.station!.availableBikes
                    pinColor = stationAnnotation.pinAvailableBikesColor!
                } else {
                    availableLabelNumber = stationAnnotation.station!.availableBikeStands
                    pinColor = stationAnnotation.pinAvailableStandsColor!
                }
                pinAnnotationView.image = pinAnnotationView.image?.maskWithColor(color: pinColor)
                
                
                let availableLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
                availableLabel.textColor = UIColor.white
                availableLabel.text = String(availableLabelNumber)
                availableLabel.textAlignment = .center
                pinAnnotationView.addSubview(availableLabel)
                let rightButton = UIButton(type: .custom)
                
                
                
                if (stationAnnotation.station?.type == .favorite){
                    rightButton.setImage(#imageLiteral(resourceName: "fleche_pleine"), for: .normal)
                } else {
                    rightButton.setImage(#imageLiteral(resourceName: "fleche_creuse"), for: .normal)
                }
                
                
                
                
                rightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                pinAnnotationView.rightCalloutAccessoryView = rightButton
                
                //pinAnnotationView.canShowCallout = true
                
                
                //pinAnnotationView.pinTintColor = stationAnnotation.pinColor
                
                
                
                return pinAnnotationView
            }
        }
        return nil
    }
    
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let stationAnnotation = view.annotation as? StationAnnotation else { return }
        if let station = stationAnnotation.station {
            if (stationAnnotation.station?.type ==  StationType.favorite) {
                stationAnnotation.station?.setType(.standard)
                if let indexToRemove = self.favouritesStationsId.index(of: station.number) {
                    self.favouritesStationsId.remove(at: indexToRemove)
                }
            } else {
                stationAnnotation.station?.setType(.favorite)
                self.favouritesStationsId.append(station.number)
            }
            
        }
        /*
         var  message = "Bikes data unavailable"
         if let station = stationAnnotation.station {
         message = "\(station.availableBikes) / \(station.bikeStands)"
         }
         let alertController = UIAlertController(title: "Available bikes", message: message, preferredStyle: .alert)
         // I call it 'dismissAction' because the 'OK' button do nothing more.
         let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(dismissAction)
         present(alertController, animated: true, completion: nil)
         
         */
        
        //addAllStationAnnotations()
        self.mapView.removeAnnotation(stationAnnotation)
        self.mapView.addAnnotation(stationAnnotation)
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let stationAnnotation = view.annotation as? StationAnnotation else { return }
        
        if let station = stationAnnotation.station {
            let latitude = station.latitude
            let longitude = station.longitude
            mapView.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), animated: true)
            //        self.addAllStationAnnotations()
            //            performSegue(withIdentifier: "openStationPopOver", sender: self)
            //centerView(at: CLLocation(latitude: latitude, longitude: longitude) , radius: 0.04)
        }
    }
    
    
    func centerView(at location: CLLocation, radius: Double) {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: radius, longitudeDelta: radius))
        self.mapView.setRegion(region, animated: true)
    }
    
    
    
    @IBAction func standBikeSegmentedChanged(_ sender: UISegmentedControl) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        addAllStationAnnotations()
    }
    
    
    
    
    
    
    
    
    
    
    // TEST PIN CUSTO
    func detailsRequestedForStation(station: Station) {
        self.selectedStation = station
        self.performSegue(withIdentifier: "stationDetails", sender: nil)
    }
    
    
    private func removeStation(from stationList: [Int], with stationId: Int) -> [Int] {
        var resultList = stationList
        if let indexStandard = stationList.index(of: stationId) {
            resultList.remove(at: indexStandard)
        }
        return resultList
        
    }
    
    private func addStation(to stationList: [Int], with stationId: Int) -> [Int] {
        var resultList = stationList
        if !(stationList.contains(stationId)) {
            resultList.append(stationId)
        }
        return resultList
    }
    
    func updateStationType(station: Station) {
        if(station.type == .favorite) && (self.favouritesStationsId.index(of: station.number) == nil) {
            self.favouritesStationsId.append(station.number)
        }
        let stationId = station.number
        
        switch station.type {
        case .standard:
            self.favouritesStationsId = removeStation(from: self.favouritesStationsId, with: stationId)
            self.workStationsId = removeStation(from: self.workStationsId, with: stationId)
            self.homeStationsId = removeStation(from: self.homeStationsId, with: stationId)
        case .favorite:
            self.workStationsId = removeStation(from: self.workStationsId, with: stationId)
            self.homeStationsId = removeStation(from: self.homeStationsId, with: stationId)
            self.favouritesStationsId = addStation(to: self.favouritesStationsId, with: stationId)
        case .home:
            self.favouritesStationsId = removeStation(from: self.favouritesStationsId, with: stationId)
            self.workStationsId = removeStation(from: self.workStationsId, with: stationId)
            self.homeStationsId = addStation(to: self.homeStationsId, with: stationId)
        case .work:
            self.favouritesStationsId = removeStation(from: self.favouritesStationsId, with: stationId)
            self.homeStationsId = removeStation(from: self.homeStationsId, with: stationId)
            self.workStationsId = addStation(to: self.workStationsId, with: stationId)
            
        }
        addAllStationAnnotations()
    }
    
    
    // -MARK: StationListProvider Implementation
    
    func getStationList() -> [Station]? {
        return self.stations
    }
}


