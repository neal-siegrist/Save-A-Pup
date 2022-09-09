//
//  AnimalResultsWrapper.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/7/22.
//

import Foundation

class AnimalResultsWrapper {
    
    private var results: AnimalResults?
 
    let urlBuilder: AnimalURLBuilder = AnimalURLBuilder()
    let networkingSession: NetworkingSession = NetworkingSession<AnimalResults>()
    
    func getAnimals() -> [Animal] {
        return results?.animals ?? []
    }
    
    func getAnimalsCount() -> Int {
        return results?.animals?.count ?? 0
    }
    
    func fetchAnimals(completion: @escaping () -> Void) throws {
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
