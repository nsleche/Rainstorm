//
//  NetworkManager.swift
//  Rainstorm
//
//  Created by Alves Jorge on 10/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation

class NetworkManager: NetworkService {
    
    func fetchData(withURL url: URL, completion: @escaping NetworkService.FetchDataCompletion) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
}
