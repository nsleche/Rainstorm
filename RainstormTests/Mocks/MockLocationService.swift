//
//  MockLocationService.swift
//  RainstormTests
//
//  Created by Alves Jorge on 10/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation
@testable import Rainstorm

class MockLocationService: LocationService {
    
    var location: Location? = Location(latitude: 51.50998, longitude: -0.1337)
    var delay: TimeInterval = 0.0
    
    func fetchLocation(completion: @escaping LocationService.FetchLocationCompletion) {
        let result: Result<Location>
        
        if let location = location {
            result = .success(location)
        } else {
            result = .failure(LocationServiceError.notAuthorizedToRequestLocation)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            completion(result)
        }
    }
    
    
}
