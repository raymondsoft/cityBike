//
//  StationAnnotationView.swift
//  cityBike
//
//  Created by etudiant-09 on 29/03/2017.
//  Copyright © 2017 etudiant-09. All rights reserved.
//

import MapKit


class StationAnnotationView: MKAnnotationView {
    
    weak var stationView : DetailStationView?
    weak var stationDelegate : StationMapViewDelegate?
    
    override var annotation: MKAnnotation? {
        willSet {
            stationView?.removeFromSuperview()
        }
    }
    
    // MARK: - LifeCycle
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.canShowCallout = false
    }
    
    
    // MARK: - callout showing and dismiss
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if(selected) {
            self.stationView?.removeFromSuperview()
            
            if let newStationView = loadStationDetailView() {
                // We place the stationView
                newStationView.frame.origin.x -= newStationView.frame.width / 2.0 - (self.frame.width / 2.0)
                newStationView.frame.origin.y -= newStationView.frame.height
                
                // We load the storybord view in the station View
                self.addSubview(newStationView)
                self.stationView = newStationView
                self.stationView?.colorizeButtons()
                // Animation
                if animated {
                    self.stationView!.alpha = 0.0
                    UIView.animate(withDuration: 0.3, animations: {
                        self.stationView?.alpha = 1.0
                    })
                }
            }
        } else {
            if stationView != nil {
                if animated {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.stationView?.alpha = 0.0
                    }, completion: {
                        (success) in
                        self.stationView?.removeFromSuperview()
                    })
                } else {
                    self.stationView?.removeFromSuperview()
                }
            }
        }
    }
    
    
    
    func loadStationDetailView() -> DetailStationView? {
        
        if let views = Bundle.main.loadNibNamed("stationPinView", owner: self, options: nil) as? [DetailStationView] , views.count > 0 {
            let detailStationView = views.first!
            detailStationView.delegate = self.stationDelegate
            if let stationAnnotation = annotation as? StationAnnotation {
                let station = stationAnnotation.station!
                detailStationView.configureWithStation(station)
            }
            return detailStationView
        }
        // TODO: - Change frame size
        //let view = UIView(frame: CGRect(x: 0, y: 0, width: 240, height: 280))
        
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.stationView?.removeFromSuperview()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let parentHitView = super.hitTest(point, with: event) {
            return parentHitView
        } else {
            if stationView != nil {
                return stationView!.hitTest(convert(point, to: stationView!), with: event)
            }
            else {
                return nil
            }
        }
    }
}
