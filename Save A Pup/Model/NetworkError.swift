//
//  NetworkError.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/31/22.
//

import Foundation

enum NetworkError: Error {
    case badToken
    case badUrl
    case badRequest
    case noData
    case parsingError
}
