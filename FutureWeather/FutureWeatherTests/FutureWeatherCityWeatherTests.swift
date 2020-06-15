//
//  FutureWeatherTests.swift
//  FutureWeatherTests
//
//  Created by Mushtaque Ahmed on 15/06/2020.
//  Copyright © 2020 Mushtaque Ahmed. All rights reserved.
//

import XCTest
@testable import FutureWeather

class FutureWeatherCityWeatherTests: XCTestCase {
    var sut : NetworkManager?
    var expectation : XCTestExpectation!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
         super.setUp()
                let url = URL(string:String(format: Constants.ServerApi.getCurrentCityWeather, "London"))!
                let urlResponse = HTTPURLResponse(
                                 url: url,
                                 statusCode: 200,
                                 httpVersion: nil,
                                 headerFields: nil)
                let data = Helper.readJsonFile(at: "CityWeather", ofType: ".json")
                let sessionMock = URLSessionMock(with: data, response: urlResponse, error: nil)
                
                sut = NetworkManager(with: HttpClient(session: sessionMock))
                expectation = expectation(description: "Status Code: 200")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCurrentCityApiWithMock() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let url = URL(string:String(format: Constants.ServerApi.getCurrentCityWeather, "London"))!
        
        let dataTask = sut?.httpClient.session?.dataTask(with: url) {
                  data, response, error in
                  if let error = error {
                      print(error.localizedDescription)
                  } else if let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 {
                      do {
                          let cityweather : CityWeather = try CustomDecoder.decodeData(data, of: CityWeather.self) as! CityWeather
                          print("currentCity \(cityweather)")
                        
                        XCTAssertTrue(cityweather.weather?[0].id == 300)
                      } catch  {
                          print("Throwable Error \(error)")
                          XCTFail("Throwable Error \(error)")
                      }
                  }
            self.expectation.fulfill()
              }
        dataTask?.resume()
        wait(for: [expectation], timeout: 15)
    }
    
}
