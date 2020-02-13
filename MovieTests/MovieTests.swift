//
//  MovieTests.swift
//  MovieTests
//
//  Created by Yen on 2020/2/9.
//  Copyright © 2020 Yen. All rights reserved.
//
import Foundation
import XCTest


@testable import Movie

class MovieTests: XCTestCase {

    let sort_by = "release_date.desc"
    let release_date = "2016-12-31"
    let model = Home_View_Model(dataService: DataService())
    let Detail_model = Detail_View_Model(dataService: DataService())
    var model_home:M_Home?
    
// MARK: - Detail_View_Model
    
    func test_detect_value_exist()
    {
//case 1 four value exist
        
        people_str = "1"
        time_str = "10:30"
        date_str = "2/14(五)"
        time_type = "IMAX"
        let error = Detail_model.detect_value_exist()
        XCTAssertEqual(error,.no_error)
        
//case 2 people_str no exist
        
        people_str = nil
        time_str = "10:30"
        date_str = "2/14(五)"
        time_type = "IMAX"
        let error2 = Detail_model.detect_value_exist()
        XCTAssertEqual(error2,.error_people)
        
//case 3 time_str no exist
        people_str = "1"
        time_str = nil
        date_str = "2/14(五)"
        time_type = "IMAX"
        let error3 = Detail_model.detect_value_exist()
        XCTAssertEqual(error3,.error_time)
//case 4 date_str no exist
        people_str = "1"
        time_str = "10:30"
        date_str =  nil
        time_type = "IMAX"
        let error4 = Detail_model.detect_value_exist()
        XCTAssertEqual(error4,.error_date)
        
    }
    
    
// MARK: - Home_View_Model

   func test_Change_Like()
   {
        XCTAssertEqual(model.Change_Like(love: 1.1), "1.1K Likes")
        XCTAssertEqual(model.Change_Like(love: 0.6), "600 Likes")
   }
    
   func test_Movie_Discover()
   {
        var items = [results_array]()
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Discover", ofType: "json")
        let result = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        model_home = try? JSONDecoder().decode(M_Home.self, from: result!)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encoded = try! encoder.encode(model_home)
        debugPrint(String(data: encoded, encoding: .utf8)!)
       
        // model.Parse_data(M_Home: model_home!, Page: 1)
         items = (model_home?.results)!
        XCTAssertEqual(model_home?.total_pages, 500)
         
        XCTAssertEqual(items[0].id, 432374)
   }
    

// MARK: - DataService  test api reponse

    func test_Https_Discover()
    {
        let e = expectation(description: "Alamofire")

        let dataService =  DataService()
        dataService.Https_Discover(Page: 2, sort_by: sort_by, primary_release_date: release_date,completion: {(M_Home, error) in
     
           debugPrint("----> test_Https_Discover \(M_Home?.total_pages ?? 510)")
           XCTAssertEqual(M_Home?.total_pages, 500)
            e.fulfill()
         })
        
        waitForExpectations(timeout: 5.0, handler: nil)

    }
    
    func test_Https_Detail()
    {
        let e = expectation(description: "Alamofire")

        let dataService =  DataService()
        dataService.Https_Detail(id: 270776 ,completion: { (M_Detail, error) in
     
           XCTAssertEqual(M_Detail?.id, 270776)
            e.fulfill()
         })
        
        waitForExpectations(timeout: 5.0, handler: nil)

    }

    
    
    

    
    
}
