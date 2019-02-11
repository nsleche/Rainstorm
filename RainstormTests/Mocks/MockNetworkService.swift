//
//  MockNetworkService.swift
//  RainstormTests
//
//  Created by Alves Jorge on 10/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation
@testable import Rainstorm

final class MockNetworkService: NetworkService {
    
    var data: Data?
    var status: Int = 200
    var error: Error?
    
    func fetchData(withURL url: URL, completion: @escaping NetworkService.FetchDataCompletion) {
        let response = HTTPURLResponse(url: url, statusCode: status, httpVersion: nil, headerFields: nil)
        completion(data, response, error)
    }
    
    
    
    
}
