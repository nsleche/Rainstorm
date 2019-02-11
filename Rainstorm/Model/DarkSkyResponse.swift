//
//  DarkSkyResponse.swift
//  Rainstorm
//
//  Created by Alves Jorge on 01/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation

struct DarkSkyResponse: Codable {
    
    struct Conditions: Codable {
        let time: Date
        let icon: String
        let summary: String
        let windSpeed: Double
        let temperature: Double
    }
    
    struct Daily: Codable {
        let data: [Conditions]
        
        struct Conditions: Codable {
            let time: Date
            let icon: String
            let windSpeed: Double
            let temperatureMin: Double
            let temperatureMax: Double
        }
        
    }
    
    let latitude: Double
    let longitude: Double
    
    let daily: Daily
    let currently: Conditions
    
}

extension DarkSkyResponse: WeatherData {
    var current: CurrentWeatherConditions {
        return currently
    }
    
    var forecast: [ForecastWeatherConditions] {
        return daily.data
    }
}

extension DarkSkyResponse.Conditions: CurrentWeatherConditions {
    
}

extension DarkSkyResponse.Daily.Conditions: ForecastWeatherConditions {
    
}
