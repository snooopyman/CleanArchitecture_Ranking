//
//  LoginRepositoryType.swift
//  PowerRanking
//
//  Created by Armando Cáceres on 28/2/25.
//

protocol LoginRepositoryType: Sendable {
    func checkLogin() async -> Result<LoginDTO, LoginDomainError>
}
