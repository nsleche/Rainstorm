//
//  WeekDayViewModelTests.swift
//  RainstormTests
//
//  Created by Alves Jorge on 03/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import XCTest
@testable import Rainstorm

class WeekDayViewModelTests: XCTestCase {

    var viewModel: WeekDayViewModel!
    
    override func setUp() {
        super.setUp()
        
        let data = loadStub(name: "darksky", extension: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let response = try! decoder.decode(DarkSkyResponse.self, from: data)
        viewModel = WeekDayViewModel(weatherData: response.forecast[2])
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    // MARK: - Tests for Day
    
    func testDay() {
        XCTAssertEqual(viewModel.day, "Monday")
    }
    
    // MARK: - Tests for Date
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "February 4")
    }
    
    // MARK: - Tests for Temperature
    
    func testTemperature() {
        XCTAssertEqual(viewModel.temperature, "43.8 F - 50.1 F")
    }
    
    // MARK: - Tests for Wind Speed
    
    func testWindSpeed() {
        XCTAssertEqual(viewModel.windspeed, "9 MPH")
    }
    
    // MARK: - Tests for Images
    
    func testImage() {
        let viewModelImage = viewModel.image
        let imageDataViewModel = viewModelImage!.pngData()!
        let imageDataReference = UIImage(named: "rain")!.pngData()!
        
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage!.size.width, 45.0)
        XCTAssertEqual(viewModelImage!.size.height, 45.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }

}
