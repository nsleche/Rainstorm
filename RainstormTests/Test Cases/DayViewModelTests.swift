//
//  DayViewModelTests.swift
//  RainstormTests
//
//  Created by Alves Jorge on 02/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import XCTest
import UIKit
@testable import Rainstorm

class DayViewModelTests: XCTestCase {
    
    var viewModel: DayViewModel!
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter
    }()

    override func setUp() {
        let data = loadStub(name: "darksky", extension: "json")
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        let darkskypResponse = try! jsonDecoder.decode(DarkSkyResponse.self, from: data)
        viewModel = DayViewModel(weatherData: darkskypResponse.current)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "Saturday, February 2, 2019")
    }

    func testTime() {
        XCTAssertEqual(viewModel.time, "4:27:51 PM")
    }
    
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Mostly Cloudy")
    }
    
    func testTemperatute() {
        XCTAssertEqual(viewModel.temperature, "54.19 F")
    }
    
    func testWindspeed() {
        XCTAssertEqual(viewModel.windspeed, "12 MPH")
    }
    
    func testImage() {
        // partly-cloudy-day
        let viewModelImage = viewModel.image
        let imageDataViewModel = viewModelImage!.pngData()!
        let imageDataReference = UIImage(named: "cloudy")!.pngData()!
        
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage!.size.width, 45.0)
        XCTAssertEqual(viewModelImage!.size.height, 33.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }

}
