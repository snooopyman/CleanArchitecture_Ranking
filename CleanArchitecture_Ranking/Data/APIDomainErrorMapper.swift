//
//  APIDomainErrorMapper.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import Foundation

final class APIDomainErrorMapper: Sendable {
    func map(error: HTTPClientError) -> APIDomainError {
        switch error {
        case .unauthorized:
            return .notAuthenticated
        default:
            return .generic
        }
    }
}
