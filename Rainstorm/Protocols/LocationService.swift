//
//  LocationService.swift
//  Rainstorm
//
//  Created by Alves Jorge on 05/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationServiceError: Error {
    case notAuthorizedToRequestLocation
}

protocol LocationService {
    typealias FetchLocationCompletion = (Result<Location>) -> Void
    
    func fetchLocation(completion: @escaping FetchLocationCompletion)
}
