//
//  ShelterResultsWrapper.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/4/22.
//

import Foundation

class ShelterResultsWrapper {
    
    private var results: ShelterResults?
    
    let urlBuilder: ShelterURLBuilder = ShelterURLBuilder()
    let networkingSession: NetworkingSession = NetworkingSession<ShelterResults>()
    
    func getShelters() -> [Shelter] {
        return results?.organizations ?? []
    }
    
    func getSheltersCount() -> Int {
        return results?.organizations?.count ?? 0
    }
    
    func fetchShelters(completion: @escaping () -> Void) throws {
        guard let url = URL(string: urlBuilder.constructURL()) else { throw NetworkError.badUrl }
        
        networkingSession.request(url: url) { result in
            switch result {
            case .success(let result):
                self.results = result
                completion()
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
