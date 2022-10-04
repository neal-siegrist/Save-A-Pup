//
//  AnimalResultsWrapper.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/7/22.
//

import Foundation

class AnimalResultsWrapper {
    
    private var results: AnimalResults?
    private var pagination: PaginationInfo?
    private var nextPage: String?
    private var animals: [Animal] = []
 
    let urlBuilder: AnimalURLBuilder = AnimalURLBuilder()
    let networkingSession: NetworkingSession = NetworkingSession<AnimalResults>()
    
    func getAnimals() -> [Animal] {
        return animals
    }
    
    func getAnimalsCount() -> Int {
        return animals.count
    }
    
    func fetchAnimals(isFetchingNextPage: Bool = false, completion: @escaping () -> Void) throws {
        
        let url: URL?
        
        if isFetchingNextPage {
            if let nextPage = nextPage {
                url = URL(string: "\(Constants.NetworkingConstants.baseURL)\(nextPage)")
            } else {
                throw NetworkError.badUrl
            }
        } else {
            url = URL(string: urlBuilder.constructURL())
        }
        
        guard let validURL = url else { throw NetworkError.badUrl }
        
        networkingSession.request(url: validURL) { [weak self] result in
            switch result {
            case .success(let result):
                
                let newAnimals = result.animals ?? [Animal]()
                
                if isFetchingNextPage {
                    self?.animals.append(contentsOf: newAnimals)
                } else {
                    self?.animals = newAnimals
                }
                
                self?.pagination = result.pagination
                self?.nextPage = self?.pagination?._links?.next?.href
                
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func isNextPageAvailable() -> Bool {
        return nextPage != nil && !nextPage!.isEmpty
    }
}
