//
//  DayViewModel.swift
//  Rainstorm
//
//  Created by Alves Jorge on 02/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

struct DayViewModel {
    let weatherData: CurrentWeatherConditions
    
    private let dateFormatter = DateFormatter()
    
    var date: String {
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: weatherData.time)
    }
    
    var time: String {
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .none
        return dateFormatter.string(from: weatherData.time)
    }
    
    var summary: String {
        return weatherData.summary
    }
    
    var temperature: String {
        return String(format: "%.2f F", weatherData.temperature)
    }
    
    var windspeed: String {
        return String(format: "%.f MPH", weatherData.windSpeed)
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(with: weatherData.icon)
    }
}
