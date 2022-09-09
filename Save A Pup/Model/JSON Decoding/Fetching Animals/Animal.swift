//
//  Animal.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/7/22.
//

import Foundation

struct Animal: Codable {
    let id: Int?
    let organization_id: String?
    let url: String?
    let type: String?
    let species: String?
    let breeds: Breed?
    let colors: Color?
    let age: String?
    let gender: String?
    let size: String?
    let coat: String?
    let attributes: AnimalAttribute?
    let environment: AnimalEnvironment?
    let tags: [String?]
    let name: String?
    let description: String?
    let organization_animal_id: String?
    let photos: [Photo?]
    let primary_photo_cropped: Photo?
    let status: String?
    let status_changed_at: String?
    let published_at: String?
    let distance: Double?
    let contact: Contact?
}
