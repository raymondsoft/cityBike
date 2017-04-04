//
//  StationAnnotation.swift
//  cityBike
//
//  Created by etudiant-09 on 27/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import Foundation
import MapKit

class StationAnnotation : NSObject, MKAnnotation {
    
    fileprivate var coord : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var coordinate: CLLocationCoordinate2D {
        get {
            return coord
        }
    }
    var title: String?
    var subtitle: String?
    var station : Station?
    
    var pinColor : UIColor?
    
    
    var pinAvailableBikesColor : UIColor?
    var pinAvailableStandsColor : UIColor?
    
    
    
    func setCoordinate(_ newCoordinate: CLLocationCoordinate2D)
    {
        self.coord = newCoordinate
    }
    

    func buildAnnotationFromStation(_ station: Station, type: StationType) {
        self.setCoordinate(CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude))
        self.title = station.name.trimBefore("-")
        self.subtitle = station.address.trimBefore("-")
        self.station = station
        self.station?.setType(type)
        
        if station.isOpen {
            self.pinColor = UIColor.green
        } else {
            self.pinColor = UIColor.black
        }
        
        setPinsColors()
    }
    
    
    private func setPinsColors() {
        self.pinAvailableBikesColor = self.station?.availableBikeColor
        self.pinAvailableStandsColor = self.station?.availableStandColor
//        setAvailableBikePinColor()
//        setAvailableStandsPinColor()
    }
    /*
    private func setAvailableBikePinColor() {
        let percentage = Float(self.station!.availableBikes) / Float(self.station!.bikeStands)
        var red : Float = 1
        var green : Float = 1
        var blue : Float = 1
        let alpha : Float = 1
        
        switch percentage {
        case 0..<0.25:
            red = 1
            green = percentage * 2.0
            blue = 0
        case 0.25...0.5:
            red = -4 * percentage + 2
            green = percentage * 2.0
            blue = 0
            
        default:
            red = 0
            green = 1
            blue = 0
        }

        self.pinAvailableBikesColor = UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
    }
    
    private func setAvailableStandsPinColor() {
        let percentage = Float(self.station!.availableBikeStands) / Float(self.station!.bikeStands)
        var red : Float = 1
        var green : Float = 1
        var blue : Float = 1
        let alpha : Float = 1
        
        switch percentage {
        case 0..<0.25:
            red = 1
            green = percentage * 2.0
            blue = 0
        case 0.25...0.5:
            red = -4 * percentage + 2
            green = percentage * 2.0
            blue = 0
            
        default:
            red = 0
            green = 1
            blue = 0
        }
        self.pinAvailableStandsColor = UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: alpha)
    }
    
    */
    
    

}

