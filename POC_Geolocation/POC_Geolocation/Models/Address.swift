//
//  Address.swift
//  POC_Geolocation
//
//  Created by marilise morona on 18/12/23.
//

import Foundation
import CoreLocation
import Contacts

struct Address {
    var name: String
    var placemark: CLPlacemark
    var postalAddress: CNPostalAddress

    init(name: String, placemark: CLPlacemark, postalAddress: CNPostalAddress) {
        self.name = name
        self.placemark = placemark
        self.postalAddress = postalAddress
    }
}
