//
//  UserDefaults+Extension.swift
//  Rainstorm
//
//  Created by Alves Jorge on 09/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let didFetchWeatherData = "didFetchWeatherData"
    }
    
    class var didFetchWeatherData: Date? {
        get {
            return UserDefaults.standard.object(forKey: Keys.didFetchWeatherData) as? Date
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.didFetchWeatherData)
        }
    }
}
