//
//  WeekDayViewModel.swift
//  Rainstorm
//
//  Created by Alves Jorge on 03/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

struct WeekDayViewModel: WeekDayRepresentable {
    
    let weatherData: ForecastWeatherConditions
    
    private let dateFormatter = DateFormatter()
    
    var day: String {
        dateFormatter.dateFormat = "EEEE"

        return dateFormatter.string(from: weatherData.time)
    }
    
    var date: String {
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: weatherData.time)
    }
    
    var temperature: String {
        let min = String(format: "%.1f F", weatherData.temperatureMin)
        let max = String(format: "%.1f F", weatherData.temperatureMax)
        return "\(min) - \(max)"
    }
    
    var windspeed: String {
        return String(format: "%.f MPH", weatherData.windSpeed)
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(with: weatherData.icon)
    }
}
