//
//  HTTPClientError.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

enum HTTPClientError: Error {
    case clientError
    case serverError
    case unauthorized
    case invalidResponse
    case parsingError
}
