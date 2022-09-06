//
//  PaginationInfo.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/1/22.
//

import Foundation

struct PaginationInfo: Codable {
    let count_per_page: Int?
    let total_count: Int?
    let current_page: Int?
    let total_pages: Int?
    let _links: PaginationLink?
}
