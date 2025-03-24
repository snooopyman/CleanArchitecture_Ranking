//
//  CheckLoginRepositoryType.swift
//  PowerRanking
//
//  Created by Armando Cáceres on 28/2/25.
//

protocol CheckLoginRepositoryType: Sendable {
    func checkLogin() async -> Result<LoginDTO, APIDomainError>
}
