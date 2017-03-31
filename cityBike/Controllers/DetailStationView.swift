//
//  DetailStationView.swift
//  cityBike
//
//  Created by etudiant-09 on 28/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import UIKit

private let BUTTON_NOT_SELECTED_COLOR = UIColor.red
private let BUTTON_SELECTED_COLOR = UIColor.green

protocol StationMapViewDelegate: class {
    func detailsRequestedForStation(station : Station)
    
    func updateStationType(station : Station)
}


class DetailStationView: UIView {
    
    @IBOutlet weak var stationNameLabel: UILabel!
    
    @IBOutlet weak var totalBikeStands: UILabel!
    
    @IBOutlet weak var freeBikeStands: UILabel!
    
    @IBOutlet weak var occupiedBikeStands: UILabel!
    
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var workButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    
    var station : Station!
    
    weak var delegate: StationMapViewDelegate?
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    func setStation(station: Station) {
        self.station = station
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*
         self.stationNameLabel.text = station.name
         self.totalBikeStands.text = String(station.bikeStands)
         self.freeBikeStands.text = String(station.availableBikeStands)
         self.occupiedBikeStands.text = String(station.availableBikes)
         */
    }
    
    
    
    
    func configureWithStation(_ station: Station) {
        self.station = station
        self.stationNameLabel.text = station.name
        self.totalBikeStands.text = String(station.bikeStands)
        self.freeBikeStands.text = String(station.availableBikeStands)
        self.occupiedBikeStands.text = String(station.availableBikes)
        colorizeButtons()
        
    }
    
    func colorizeButtons()  {
        
        // We set all button gray.
        self.homeButton.imageView?.image = self.homeButton.imageView?.image?.maskWithColor(color: BUTTON_NOT_SELECTED_COLOR)
        self.workButton.imageView?.image = self.workButton.imageView?.image?.maskWithColor(color: BUTTON_NOT_SELECTED_COLOR)
        self.favoriteButton.imageView?.image = self.favoriteButton.imageView?.image?.maskWithColor(color: BUTTON_NOT_SELECTED_COLOR)
        
        // Now, if the stationType is not standard, we set the correct button Black
        
        switch self.station.type {
        case .standard:
            break
        case .favorite:
            self.favoriteButton.imageView!.image = self.favoriteButton.imageView!.image!.maskWithColor(color: BUTTON_SELECTED_COLOR)
        case .home:
            self.homeButton.imageView?.image = self.homeButton.imageView?.image?.maskWithColor(color: BUTTON_SELECTED_COLOR)
        case .work:
            self.workButton.imageView?.image = self.workButton.imageView?.image?.maskWithColor(color: BUTTON_SELECTED_COLOR)
            
        }
        
        
    }
    
    @IBAction func HomeButtonPressed(_ sender: UIButton) {
        if(self.station.type == .home) {
            self.station.type = .standard
            self.homeButton.imageView?.image = self.homeButton.imageView?.image?.maskWithColor(color: BUTTON_NOT_SELECTED_COLOR)
        } else {
            self.station.type = .home
            colorizeButtons()
            self.homeButton.imageView?.image = self.homeButton.imageView?.image?.maskWithColor(color: BUTTON_SELECTED_COLOR)
        }
        self.delegate?.updateStationType(station: self.station)
    }
    
    @IBAction func workButtonPressed(_ sender: UIButton) {
        if (self.station.type == .work) {
            self.station.type = .standard
        } else {
            self.station.type = .work
        }
        self.delegate?.updateStationType(station: self.station)
        colorizeButtons()
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        if (self.station.type == .favorite) {
            self.station.type = .standard
        } else {
            self.station.type = .favorite
        }
        self.delegate?.updateStationType(station: self.station)
        colorizeButtons()
    }
    
}
