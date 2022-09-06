//
//  Networking.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/31/22.
//

import Foundation

class Networking {
    
    enum HttpMethodType: String {
        case GET
        case POST
    }
    
    /// Retrieves the PetFinder API token and calls the provided completion
    /// passing the token or the error that occured.
    ///
    /// - Parameter completion: Completion handler to be called when the token is retrieved or an error occurs.
    static func fetchToken(completion: @escaping (Result<Token, NetworkError>) -> Void) {
        let result: Result<Token, NetworkError>
        
        let headerFields = ["application/json": "Content-Type"]
        let bodyParameters: [String: String] = [
            "grant_type": "client_credentials",
            "client_id": ApiKeys.API_KEY,
            "client_secret": ApiKeys.API_SECRET
        ]
        
        guard let url = URL(string: Constants.NetworkingConstants.apiTokenUrl) else {
            result = .failure(.badUrl)
            completion(result)
            return
        }
        
        guard let request = generateUrlRequest(url: url, bodyParameters: bodyParameters, headerFields: headerFields, httpMethod: .POST) else {
            result = .failure(.badRequest)
            completion(result)
            return
        }
        
        loadData(request: request, type: Token.self, completion: completion)
    }
    
    static func generateUrlRequest(url: URL, bodyParameters: [String: String] = [:], headerFields: [String: String] = [:], httpMethod: HttpMethodType) -> URLRequest? {
        var request = URLRequest(url: url)
        
        if httpMethod == .POST {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters) else { return nil }
            
            request.httpBody = httpBody
        }
        
        request.httpMethod = httpMethod.rawValue
        
        headerFields.forEach { key, value in
            request.setValue(key, forHTTPHeaderField: value)
        }
        
        return request
    }
    
    static func loadData<T: Decodable>(request: URLRequest, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
 
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let validData = data else {
                completion(Result<T, NetworkError>.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result: Result<T, NetworkError> = try .success(decoder.decode(T.self, from: validData))
                completion(result)
            } catch {
                let decodingError = error as? DecodingError
                print(decodingError.debugDescription)
                completion(Result<T, NetworkError>.failure(.parsingError))
            }
        }
        
        dataTask.resume()
    }
}
