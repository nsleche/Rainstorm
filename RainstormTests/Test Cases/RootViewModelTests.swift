//
//  RootViewModelTests.swift
//  RainstormTests
//
//  Created by Alves Jorge on 10/02/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import XCTest
@testable import Rainstorm

class RootViewModelTests: XCTestCase {
    
    var viewModel: RootViewModel!
    var locationService: MockLocationService!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        
        locationService = MockLocationService()
        mockNetworkService = MockNetworkService()
        mockNetworkService.data = loadStub(name: "darksky", extension: "json")
        viewModel = RootViewModel(locationManager: locationService, networkManager: mockNetworkService)
    }

    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: "didFetchWeatherData")
    }
    
    func testRefresh_Success() {
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        viewModel.didFetchWeatherData = { (result) in
            if case .success(let data) = result {
                print(data)

                XCTAssertEqual(data.latitude, 37.335114)
                XCTAssertEqual(data.longitude, -122.008928)
                expectation.fulfill()
            }
        }
        
        viewModel.refresh()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefresh_Failure() {
        locationService.location = nil
        
        let expectation = XCTestExpectation(description: "Fetch weather error")
        viewModel.didFetchWeatherData = { result in
            if case .failure(let error as WeatherDataError) = result {
                XCTAssertEqual(error, WeatherDataError.notAuthorizedToRequestLocation)
                expectation.fulfill()
            }
        }
        
        viewModel.refresh()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    func testRefresh_FailedToFetchWeatherData_RequestFailed() {
        mockNetworkService.error = NSError(domain: "com.nschucky.network.service", code: 1001, userInfo: nil)
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error as WeatherDataError) = result {
                XCTAssertEqual(error, WeatherDataError.noWeatherDataAvailable)
                expectation.fulfill()
            }
        }
        
        viewModel.refresh()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefresh_FailedToFetchWeatherData_InvalidResponse() {
        
        mockNetworkService.data = "Data".data(using: .utf8)!
        
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error as WeatherDataError) = result {
                XCTAssertEqual(error, WeatherDataError.noWeatherDataAvailable)
                expectation.fulfill()
            }
        }
        
        viewModel.refresh()
        
        wait(for: [expectation], timeout: 2.0)
    }

    
    func testRefresh_FailedToFetchWeatherData_NoErrorNoResponse() {
        mockNetworkService.data = nil
        
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error as WeatherDataError) = result {
                XCTAssertEqual(error, WeatherDataError.noWeatherDataAvailable)
                expectation.fulfill()
            }
        }
        
        viewModel.refresh()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    
    func testApplicationWillEnterForeground_NoTimestamp() {
        UserDefaults.standard.removeObject(forKey: "didFetchWeatherData")
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        viewModel.didFetchWeatherData = { (result) in
            expectation.fulfill()
        }
        
        NotificationCenter.default.post(name: UIApplication.willEnterForegroundNotification, object: nil)
        
        wait(for: [expectation], timeout: 2.0)
    }

    
    func testApplicationWillEnterForeground_ShouldRefresh() {
        UserDefaults.standard.setValue(Date().addingTimeInterval(-3600.0), forKey: "didFetchWeatherData")
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        viewModel.didFetchWeatherData = { (result) in
            expectation.fulfill()
        }
        
        NotificationCenter.default.post(name: UIApplication.willEnterForegroundNotification, object: nil)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testApplicationWillEnterForeground_ShouldNotRefresh() {
        UserDefaults.standard.setValue(Date(), forKey: "didFetchWeatherData")
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        expectation.isInverted = true
        
        viewModel.didFetchWeatherData = { (result) in
            expectation.fulfill()
        }
        
        NotificationCenter.default.post(name: UIApplication.willEnterForegroundNotification, object: nil)
        
        wait(for: [expectation], timeout: 2.0)
    }

}
