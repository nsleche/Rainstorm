//
//  Location.swift
//  Rainstorm
//
//  Created by Alves Jorge on 05/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let latitude: Double
    let longitude: Double
}

extension Location {
    init(clLocation: CLLocation) {
        self.latitude = clLocation.coordinate.latitude
        self.longitude = clLocation.coordinate.longitude
    }
}
