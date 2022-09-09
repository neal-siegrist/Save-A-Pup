//
//  AnimalResults.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/7/22.
//

import Foundation

struct AnimalResults: Codable {
    let animals: [Animal]?
    let pagination: PaginationInfo?
}
