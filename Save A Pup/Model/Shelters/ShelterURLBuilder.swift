//
//  ShelterURLBuilder.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/30/22.
//

import Foundation

class ShelterURLBuilder {

    enum QueryParamater: String {
        case name
        case location
        case state
        case country
        case query
    }
    
    
    private var stringValues: [String: String] = [:]
    
    
    private var distance: Int = 100
    private var sortBy: ShelterSortOptions = .distance
    private var limit: Int = 20
    private var page: Int = 1
    
    private let minLimit: Int = 20
    private let maxLimit: Int = 100
    
    
    func addParameter(parameterName: QueryParamater, paramaterValue: String) {
        stringValues[parameterName.rawValue] = paramaterValue
    }
    
    func constructURL() -> String {
        var urlString = Constants.NetworkingConstants.shelterApiUrl
        var paramsAdded = false
        
        for (param, value) in stringValues {
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
        
        return urlString
    }
}
