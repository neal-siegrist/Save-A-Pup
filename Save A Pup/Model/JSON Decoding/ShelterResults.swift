//
//  Results.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/1/22.
//

import Foundation

struct ShelterResults: Decodable {
    let organizations: [Shelter]?
    let type: String?
    let status: Int?
    let title: String?
    let detail: String?
    let pagination: PaginationInfo?
}
