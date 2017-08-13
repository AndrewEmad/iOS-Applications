//
//  Place.swift
//  My Places
//
//  Created by Andrew on 8/13/17.
//  Copyright © 2017 Andrew. All rights reserved.
//

import Foundation
import CoreLocation

class Place : NSCoder {
    var name = ""
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    init(name: String , latitude: CLLocationDegrees , longitude: CLLocationDegrees){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = (aDecoder.decodeObjectForKey("name") as? String)!
        self.latitude = (aDecoder.decodeObjectForKey("latitude") as? CLLocationDegrees)!
        self.longitude = (aDecoder.decodeObjectForKey("longitude") as? CLLocationDegrees)!
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.latitude, forKey: "latitude")
        aCoder.encodeObject(self.longitude, forKey: "longitude")
    }
}