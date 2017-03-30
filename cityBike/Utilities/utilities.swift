//
//  utilities.swift
//  cityBike
//
//  Created by etudiant-09 on 27/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import UIKit


extension String {
    var translate :String {
        return NSLocalizedString(self, comment: "")
    }
    
    func trimBefore(_ needle: String)->String {
        var output = self
        if let position = self.range(of: needle) {
            output.removeSubrange(self.startIndex..<position.upperBound)
        }
        return output
    }
    
    /**
     Supprime le numéro et le tiret pour un nom de station
     */
    var getStationName : String? {
        if let index = self.characters.index(of: "-") {
            return self.substring(from: self.index(index, offsetBy: 2))
        } else {
            return nil
        }
    }
}

class Utilities {
    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        
        image.draw(in: CGRect(x: 0, y: 0,width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    /*
     static func resizeToScreenSize(image: UIImage)->UIImage{
     
     let screenSize = self.view.bounds.size
     
     
     return resizeImage(image: image, newWidth: screenSize.width)
     }*/
}
