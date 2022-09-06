//
//  Token.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/31/22.
//

import Foundation

struct Token: Codable {
    let access_token: String?
    let expires_in: Int?
    
    //Date when this token is initialized
    let date: Date = Date()
    
    var isValid: Bool {
        guard let unwrappedSeconds = self.expires_in, let _ = access_token  else { return false }
        
        let validSeconds = TimeInterval(unwrappedSeconds)
        
        return Date.now < Date(timeInterval: validSeconds, since: self.date)
    }
}
