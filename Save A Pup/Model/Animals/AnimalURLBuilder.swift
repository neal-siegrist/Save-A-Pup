//
//  AnimalURLBuilder.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/7/22.
//

import Foundation

class AnimalURLBuilder: URLBuilder {
 
    enum QueryParamater: String {
        case age
        case breed
        case coat
        case color
        case country
        case gender
        case location
        case name
        case organization
        case query
        case size
        case state
        case status
        case type
    }
    
    private var stringValues: [String: String] = [:]
    
    private var declawed, good_with_cats, good_with_children, good_with_dogs, house_trained, special_needs : Bool?
    
    private var after: String?
    private var before: String?
    private var sort: String?
    
    private var distance: Int = 100
    private var sortBy: SortOptions = .distance
    private var page: Int = 1
    private var limit: Int = 20
    private let minLimit: Int = 20
    private let maxLimit: Int = 100
    private var nextPageLink: String?
    
    func addParameter(parameterName: AnimalURLBuilder.QueryParamater, paramaterValue: String) {
        stringValues[parameterName.rawValue] = paramaterValue
    }
    
    func clearParameters() {
        stringValues.removeAll()
    }
    
    func constructURL() -> String {
        var urlString = Constants.NetworkingConstants.animalApiUrl
        var paramsAdded = false
        
        for (param, value) in stringValues {
            print(param, value)
            
            if !paramsAdded {
                urlString.append("?")
                paramsAdded = true
            } else {
                urlString.append("&")
            }
            
            urlString.append("\(param)=\(value)")
            
            if param == QueryParamater.location.rawValue {
                urlString.append("&distance=\(distance)&sort=\(sortBy)")
            }
        }
        
        if !paramsAdded {
            urlString.append("?")
            paramsAdded = true
        } else {
            urlString.append("&")
        }
        
        urlString.append("limit=\(limit)&page=\(page)")
        
        urlString = urlString.replacingOccurrences(of: " ", with: "%20")
        
        print(urlString)
        
        return urlString
    }
}
