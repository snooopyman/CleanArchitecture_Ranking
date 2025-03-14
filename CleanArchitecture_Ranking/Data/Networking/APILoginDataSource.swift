//
//  APILoginDataSource.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import Foundation

actor APILoginDataSource: APIDataSourceType {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.httpClient = httpClient
    }
    
    func login() async -> Result<LoginDTO, HTTPClientError> {
        do {
            let token = try await FirebaseAuthHelper.getCurrentUserToken()
            print("Bearer token: ", token)
            
            let endpoint = Endpoint(
                path: "/api/login",
                method: .get,
                headers: ["Authorization": "Bearer \(token)"]
            )
            
            let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "http://localhost:3001")
            
            switch result {
            case .success(let data):
                do {
                    let loginDTO = try JSONDecoder().decode(LoginDTO.self, from: data)
                    return .success(loginDTO)
                } catch {
                    return .failure(.parsingError)
                }
            case .failure(let error):
                return .failure(error)
            }
        } catch {
            return .failure(.unauthorized)
        }
    }
}
