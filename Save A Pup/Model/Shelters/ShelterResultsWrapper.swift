//
//  ShelterResultsWrapper.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/4/22.
//

import Foundation

class ShelterResultsWrapper {
    
    private var results: ShelterResults?
    private var pagination: PaginationInfo?
    private var nextPage: String?
    private var shelters: [Shelter] = []
    
    let urlBuilder: ShelterURLBuilder = ShelterURLBuilder()
    let networkingSession: NetworkingSession = NetworkingSession<ShelterResults>()
    
    func getShelters() -> [Shelter] {
        return shelters
    }
    
    func getSheltersCount() -> Int {
        return shelters.count
    }
    
    func fetchShelters(isFetchingNextPage: Bool = false, completion: @escaping () -> Void) throws {
        
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
                
                let newShelters = result.organizations ?? [Shelter]()
                
                if isFetchingNextPage {
                    self?.shelters.append(contentsOf: newShelters)
                } else {
                    self?.shelters = newShelters
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
