//
//  WeekViewModelTests.swift
//  RainstormTests
//
//  Created by Alves Jorge on 03/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import XCTest
import UIKit
@testable import Rainstorm

class WeekViewModelTests: XCTestCase {
    
    var viewModel: WeekViewModel!

    override func setUp() {
        super.setUp()
        
        let data = loadStub(name: "darksky", extension: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let response = try! decoder.decode(DarkSkyResponse.self, from: data)
        viewModel = WeekViewModel(weatherData: response.forecast)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNumberOfDays() {
        XCTAssertEqual(viewModel.weatherData.count, 8)
    }
    
    func testViewModelForIndex() {
        
        let weekDayViewModel = viewModel.viewModel(for: 2)
        
        XCTAssertEqual(weekDayViewModel.day, "Monday")
        XCTAssertEqual(weekDayViewModel.date, "February 4")
        
    }



}
