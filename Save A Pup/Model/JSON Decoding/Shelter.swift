//
//  Shelter.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/1/22.
//

import Foundation

struct Shelter: Codable {
    let id: String?
    let name: String?
    let email: String?
    let phone: String?
    let address: Address?
    let url: String?
    let website: String?
    let mission_statement: String?
    let social_media: SocialMedia?
    let photos: [Photo?]
    let distance: Double?
}
