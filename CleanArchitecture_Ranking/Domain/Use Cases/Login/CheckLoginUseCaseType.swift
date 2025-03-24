//
//  CheckLoginUseCaseType.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 13/3/25.
//

protocol CheckLoginUseCaseType: Sendable {
    func execute() async -> Result<LoginModel, APIDomainError>
}
