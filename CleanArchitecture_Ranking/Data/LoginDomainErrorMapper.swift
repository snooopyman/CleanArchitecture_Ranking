//
//  LoginDomainErrorMapper.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import Foundation

final class LoginDomainErrorMapper: Sendable {
    func map(error: HTTPClientError) -> LoginDomainError {
        switch error {
        case .unauthorized:
            return .notAuthenticated
        default:
            return .generic
        }
    }
}
