//
//  CheckLoginRepositoryMock.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 13/3/25.
//

actor CheckLoginRepositoryMock: CheckLoginRepositoryType {
    func checkLogin() async -> Result<LoginDTO, APIDomainError> {
        return .success(LoginDTO(isUserInApi: true))
    }
}
