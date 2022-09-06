//
//  Address.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/1/22.
//

import Foundation

struct Address: Codable {
    let address1: String?
    let address2: String?
    let city: String?
    let state: String?
    let postcode: String?
    let country: String?
}
