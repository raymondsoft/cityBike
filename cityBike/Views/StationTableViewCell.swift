//
//  StationTableViewCell.swift
//  cityBike
//
//  Created by etudiant-09 on 30/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {

    @IBOutlet weak var StationNameLabel: UILabel!
    
   
    @IBOutlet weak var LocalisationLabel: UILabel!
    
    @IBOutlet weak var BikeImage: UIImageView!
    @IBOutlet weak var bikesAvailable: UILabel!
    
    @IBOutlet weak var standImage: UIImageView!
    @IBOutlet weak var standsAvailable: UILabel!
    
    @IBOutlet weak var distanceToUserLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func buildFrom(station: Station){
        self.StationNameLabel.text = station.name
//        self.totalStandsLabel.text = String(station.bikeStands)
        self.LocalisationLabel.text = String(station.address)
        
        self.bikesAvailable.text = String(station.availableBikes)
        self.BikeImage.image = self.BikeImage.image?.maskWithColor(color: station.availableBikeColor)
        
        self.standsAvailable.text = String(station.availableBikeStands)
        self.standImage.image = self.standImage.image?.maskWithColor(color: station.availableStandColor)
        
        if station.distanceToUser != nil {
            self.distanceToUserLabel.text = station.distanceToUser!.toString(with: 2) + " m"
        } else {
            self.distanceToUserLabel.text = "Position Utilisateur Inconnue"
        }
    }

}
