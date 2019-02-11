//
//  WeekViewModel.swift
//  Rainstorm
//
//  Created by Alves Jorge on 02/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation

struct WeekViewModel {
    let weatherData: [ForecastWeatherConditions]
    
    var numberOfDays: Int {
        return weatherData.count
    }
    
    
    func viewModel(for index: Int) -> WeekDayViewModel {
        return WeekDayViewModel(weatherData: weatherData[index])
    }
    
}
