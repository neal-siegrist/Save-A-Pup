//
//  NetworkingSession.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/30/22.
//

import Foundation

class TokenHolder {
    static var token: Token?
}

class NetworkingSession<T: Decodable> {
    
    typealias TokenCompletion = (Result<Token, NetworkError>) -> Void
    typealias ResultCompletion = (Result<T, NetworkError>) -> Void
    
    struct Request {
        let url: URL
        let completion: NetworkingSession.ResultCompletion
    }
    
    
    private var token: Token? {
        get {
            TokenHolder.token
        } set(newToken) {
            TokenHolder.token = newToken
        }
    }
    private var unsafeRequests: [Request] = []
    
    private let requestQueue = DispatchQueue(label: "NetworkingSession.RequestQueue", qos: .userInitiated, attributes: .concurrent)
    
    func request(url: URL, completion: @escaping ResultCompletion) {
        
        if let token = token {
            if token.isValid {
                guard let urlRequest = Networking.generateUrlRequest(url: url, headerFields: ["Bearer \(token.access_token!)": "Authorization"], httpMethod: .GET) else { return }
                
                Networking.loadData(request: urlRequest, type: T.self) { result in
                    completion(result)
                }
            } else {
                safelyAddRequest(request: Request(url: url, completion: completion))
                
                fetchToken()
            }
        } else {
            safelyAddRequest(request: Request(url: url, completion: completion))
            
            fetchToken()
        }
        
    }
    
    private func fetchToken() {
        print("Fetching token...")
        Networking.fetchToken { [weak self] result in
            switch result {
            case .success(let token):
                self?.token = token
                
                self?.safelySendAllRequests()
            case .failure(let error):
                print("Error occured retrieving token. Error description: \(error.localizedDescription)")
            }
        }
    }
    
    private func safelyAddRequest(request: Request) {
        requestQueue.async(flags: .barrier) { [weak self] in
            self?.unsafeRequests.append(request)
        }
    }
    
    private func safelySendAllRequests() {
        requestQueue.async(flags: .barrier) { [weak self] in
            
            self?.unsafeRequests.forEach({ request in
                self?.request(url: request.url, completion: request.completion)
            })
            
            self?.unsafeRequests.removeAll()
        }
    }
}
