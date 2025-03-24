//
//  APIDomainError.swift
//  PowerRanking
//
//  Created by Armando Cáceres on 28/2/25.
//

enum APIDomainError: Error, Sendable {
    case generic
    case notAuthenticated
    case apiError(HTTPClientError)
}
