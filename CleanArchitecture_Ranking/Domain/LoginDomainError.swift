//
//  LoginDomainError.swift
//  PowerRanking
//
//  Created by Armando Cáceres on 28/2/25.
//

enum LoginDomainError: Error, Sendable {
    case generic
    case notAuthenticated
    case apiError(HTTPClientError)
}
