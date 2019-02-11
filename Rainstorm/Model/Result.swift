//
//  Result.swift
//  Rainstorm
//
//  Created by Alves Jorge on 09/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation


enum Result<T> {
    case success(T)
    case failure(Error)
}
