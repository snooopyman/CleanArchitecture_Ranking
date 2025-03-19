//
//  CheckLoginRepositoryMock.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 13/3/25.
//

import Foundation

actor CheckLoginRepositoryMock: CheckLoginRepositoryType {
    func checkLogin() async -> Result<LoginDTO, LoginDomainError> {
        return .success(LoginDTO(isUserInApi: false))
    }
}
