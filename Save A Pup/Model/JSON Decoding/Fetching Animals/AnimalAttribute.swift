//
//  AnimalAttribute.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/7/22.
//

import Foundation

struct AnimalAttribute: Codable {
    let spayed_neutered: Bool?
    let house_trained: Bool?
    let declawed: Bool?
    let special_needs: Bool?
    let shots_current: Bool?
}
