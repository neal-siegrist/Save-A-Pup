//
//  Breed.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/7/22.
//

import Foundation

struct Breed: Codable {
    let primary: String?
    let secondary: String?
    let mixed: Bool?
    let unknown: Bool?
}
