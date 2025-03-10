//
//  URLSessionHTTPClient.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import Foundation

actor URLSessionHTTPClient: HTTPClient {
    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError> {
        guard let url = URL(string: baseUrl + endpoint.path) else {
            return .failure(.clientError)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        request.allHTTPHeaderFields = endpoint.headers
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }
            
            switch httpResponse.statusCode {
            case 200..<300:
                return .success(data)
            case 401:
                return .failure(.unauthorized)
            case 400..<500:
                return .failure(.clientError)
            case 500..<600:
                return .failure(.serverError)
            default:
                return .failure(.invalidResponse)
            }
        } catch {
            return .failure(.clientError)
        }
    }
}
