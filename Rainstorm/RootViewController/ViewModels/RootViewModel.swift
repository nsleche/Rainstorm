//
//  RootViewModel.swift
//  Rainstorm
//
//  Created by Alves Jorge on 31/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation
import UIKit

enum WeatherDataError: Error {
    case notAuthorizedToRequestLocation
    case failedToRequestLocation
    case noWeatherDataAvailable
}

class RootViewModel: NSObject {

    typealias FetchWeatherDataCompletion = (Result<WeatherData>) -> Void
    var didFetchWeatherData: FetchWeatherDataCompletion?
    let locationManager: LocationService
    let networkManager: NetworkService
    
    init(locationManager: LocationService, networkManager: NetworkService) {
        self.locationManager = locationManager
        self.networkManager = networkManager
        super.init()
        setupNotificationHandling()
    }
    
    private func fetchLocation() {
        locationManager.fetchLocation(completion: { (result) in
            
            switch result {
            case .success(let location):
                self.fetchWeatherData(forLocation: location)
                
            case .failure(let error):
                print("error at viewmodel level:", error)
                self.didFetchWeatherData?(.failure(WeatherDataError.notAuthorizedToRequestLocation))
            }
        })
    }
    
    private func fetchWeatherData(forLocation location: Location) {
        
        let weatherRequest = WeatherRequest(baseURL: WeatherService.authenticatedBaseURL, location: location)
        
        
        networkManager.fetchData(withURL: weatherRequest.url) { [weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("statucCode:", response.statusCode)
            }
            DispatchQueue.main.async {
                if let error = error {
                    print("error fetching weather data", error)
                    self?.didFetchWeatherData?(.failure(WeatherDataError.noWeatherDataAvailable))
                } else if let data = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    do {
                        let response = try decoder.decode(DarkSkyResponse.self, from: data)
                        UserDefaults.didFetchWeatherData = Date()
                        self?.didFetchWeatherData?(.success(response))
                    } catch {
                        print("error decoding darkskyresponse", error)
                        self?.didFetchWeatherData?(.failure(WeatherDataError.noWeatherDataAvailable))
                    }
                    
                } else {
                    self?.didFetchWeatherData?(.failure(WeatherDataError.noWeatherDataAvailable))
                }
            }
        }

    }
    
    func refresh() {
        print("refreshing")
        fetchLocation()
    }
    
    
    private func setupNotificationHandling() {
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification,
                                               object: nil,
                                               queue: OperationQueue.main) { (notification) in
                                                guard let didFetchWeatherData = UserDefaults.didFetchWeatherData else {
                                                    self.refresh()
                                                    return
                                                }
                                                
                                                if Date().timeIntervalSince(didFetchWeatherData) > Configuration.refreshThreshold {
                                                    self.refresh()
                                                }
                                                
        }
    }
}
