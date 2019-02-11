//
//  XCTestCase.swift
//  RainstormTests
//
//  Created by Alves Jorge on 02/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import XCTest

extension XCTestCase {
    func loadStub(name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)!
        return try! Data(contentsOf: url)
        
    }
}
