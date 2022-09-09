//
//  ShelterSortOptions.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/30/22.
//

import Foundation

enum SortOptions: String {
    case distance
    case revDistance = "-distance"
    case name
    case revName = "-name"
    case country
    case revCountry = "-country"
    case state
    case revState = "-state"
}
