//
//  Student.swift
//  OnTheMap
//
//  Created by Jonathan Kim on 8/8/15.
//  Copyright (c) 2015 Jonathan Kim. All rights reserved.
//

import Foundation
import MapKit

class Student {
    var firstName: String!
    var lastName: String
    var coordinate: CLLocationCoordinate2D
    var mediaURL: String
    var userUniqueID: String

    init(dictionary: NSDictionary) {

        self.firstName = dictionary["firstName"] as! String
        self.lastName = dictionary["lastName"] as! String

        var latitudeString = dictionary["latitude"] as! NSNumber
        var longitudeString = dictionary["longitude"] as! NSNumber

        var latitude = latitudeString.stringValue as NSString
        var longitude = longitudeString.stringValue as NSString

        self.coordinate = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue)

        self.mediaURL = dictionary["mediaURL"] as! String
        self.userUniqueID = dictionary["uniqueKey"] as! String
    }
}