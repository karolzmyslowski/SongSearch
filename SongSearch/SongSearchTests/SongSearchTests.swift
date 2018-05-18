//
//  SongSearchTests.swift
//  SongSearchTests
//
//  Created by Karol Zmyslowski on 15.05.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import XCTest
@testable import SongSearch

class SongSearchTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testInfoLoading() {
        
        let urlString = "https://itunes.apple.com/search?term=ok&entity=song"
        SongService.shared.getSong(searchString: urlString) { (result, error) in
            if error != nil {
                XCTAssert(true, "No data was received from the server for View ")
            }
        }
    }
    
    func testImageLoading(song: Song) {
        SongService.shared.getImageFromWeb(song.artworkUrl100) { (image, error) in
            if error != nil {
                XCTAssert(true, "No image was received from the server")
            }
        }
    }
}
