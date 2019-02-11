//
//  Configuration.swift
//  Rainstorm
//
//  Created by Alves Jorge on 30/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation

enum ServiceDefaults {
    static let location = Location(latitude: 37.335114, longitude: -122.008928)
}

enum Configuration {
    static var refreshThreshold: TimeInterval {
        #if DEBUG
        return 60.0
        #else
        return 10.0 * 60.0
        #endif
    }
}

enum WeatherService {
    private static let apiKey = "8c23c5390a6cc7fd9be949487def3e59"
    private static let baseURL = URL(string: "https://api.darksky.net/forecast/")!
    
    static var authenticatedBaseURL: URL {
        return baseURL.appendingPathComponent(apiKey)
    }
}
