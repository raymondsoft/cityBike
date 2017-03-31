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
    
    @IBOutlet weak var totalStandsLabel: UILabel!
    
    @IBOutlet weak var LocalisationLabel: UILabel!
    
    @IBOutlet weak var bikesAvailable: UILabel!
    
    @IBOutlet weak var standsAvailable: UILabel!
    
    
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
        self.totalStandsLabel.text = String(station.bikeStands)
        self.LocalisationLabel.text = String(station.address)
        self.bikesAvailable.text = String(station.availableBikes)
        self.standsAvailable.text = String(station.availableBikeStands)
    }

}
