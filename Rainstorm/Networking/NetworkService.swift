//
//  NetworkService.swift
//  Rainstorm
//
//  Created by Alves Jorge on 10/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation

protocol NetworkService: class {
    typealias FetchDataCompletion = (Data?, URLResponse?, Error?) -> Void
    
    func fetchData(withURL url: URL, completion: @escaping FetchDataCompletion)
}
