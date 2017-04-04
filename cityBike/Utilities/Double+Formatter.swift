//
//  Double+Formatter.swift
//  cityBike
//
//  Created by etudiant-09 on 31/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import Foundation

extension Double {
    func toString(with digits: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = digits
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
