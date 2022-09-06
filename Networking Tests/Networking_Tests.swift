//
//  Networking_Tests.swift
//  Networking Tests
//
//  Created by Neal Siegrist on 8/31/22.
//

import XCTest
@testable import Save_A_Pup

class Networking_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
    
    
    func testUrlRequestGeneratorForToken() throws {
        let headerFields = ["application/json": "Content-Type"]
        let bodyParameters: [String: String] = [
            "grant_type": "client_credentials",
            "client_id": ApiKeys.API_KEY,
            "client_secret": ApiKeys.API_SECRET
        ]

        guard let url = URL(string: Constants.NetworkingConstants.apiTokenUrl) else {
            XCTFail("Failure occured creating the URL.")
            throw NetworkError.badRequest
        }
        
        guard let request = Networking.generateUrlRequest(url: url, bodyParameters: bodyParameters, headerFields: headerFields, httpMethod: .POST) else {
            XCTFail("Failure occured creating the URL request.")
            throw NetworkError.badRequest
        }

        XCTAssertEqual(request.url!.absoluteString, Constants.NetworkingConstants.apiTokenUrl)
        
        XCTAssertEqual("POST", request.httpMethod!)
        
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type")!, "application/json")
    }

    
    func testTokenApiCallReceivesToken() throws {
        
        let promise = expectation(description: "Valid Token")
        
        let completion: ((Result<Token, NetworkError>) -> Void) = { result in
            switch result {
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            case .success(let token):
                if token.access_token != nil {
                    promise.fulfill()
                } else {
                    XCTFail("Token is nil.")
                }
            }
        }
        
        Networking.fetchToken(completion: completion)
        
        wait(for: [promise], timeout: 5)
    }
    
    
    
    

    //Test to ensure retrieving shelters receives a positive
    //number of results.
    func testShelterApiCall() throws {
        
        let promise = expectation(description: "Positive number of shelter results received.")
        let validUrlString = "https://api.petfinder.com/v2/organizations?query=golden&state=CA"
        guard let url = URL(string: validUrlString) else {
            XCTFail("Invalid attempt to create url from given string.")
            throw NetworkError.badUrl
        }

        Networking.fetchToken { result in
            switch result {
            case .success(let token):
                
                if !token.isValid { return }
                
                guard let request = Networking.generateUrlRequest(url: url, headerFields: ["Bearer \(token.access_token!)": "Authorization"], httpMethod: .GET) else {
                    XCTFail("Invalid attempt to create URL request.")
                    return
                }
                
                Networking.loadData(request: request, type: ShelterResults.self) { result in
                    switch result {
                    case .success(let shelterResults):
                        print(shelterResults)
                        if shelterResults.organizations!.count > 0 {
                            promise.fulfill()
                        } else {
                            XCTFail("Results count is 0.")
                        }
                    case .failure(let error):
                        XCTFail("Error: \(error.localizedDescription)")
                    }
                }
                
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }

        wait(for: [promise], timeout: 5)
    }
}
