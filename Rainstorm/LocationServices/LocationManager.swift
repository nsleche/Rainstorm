//
//  LocationManager.swift
//  Rainstorm
//
//  Created by Alves Jorge on 05/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, LocationService {
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    var didFetchLocation: FetchLocationCompletion?
    
    func fetchLocation(completion: @escaping LocationService.FetchLocationCompletion) {
        didFetchLocation = completion
        locationManager.requestLocation()
    }
    
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            didFetchLocation?(.failure(LocationServiceError.notAuthorizedToRequestLocation))
            didFetchLocation = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFetchLocation?(.failure(LocationServiceError.notAuthorizedToRequestLocation))
        print("Unable to fetch location:", error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else { return }
        didFetchLocation?(.success(Location(clLocation: firstLocation)))
        didFetchLocation = nil
    }
}
