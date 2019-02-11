//
//  WeatherRequest.swift
//  Rainstorm
//
//  Created by Alves Jorge on 30/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation

struct WeatherRequest {
    let baseURL: URL
    let location: Location
    var latitude: Double {
        return location.latitude
    }
    var longitude: Double {
        return location.longitude
    }
    
    var url: URL {
        return baseURL.appendingPathComponent("\(latitude),\(longitude)")
    }
}
