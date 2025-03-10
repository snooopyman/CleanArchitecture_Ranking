//
//  CheckLogin.swift
//  PowerRanking
//
//  Created by Armando Cáceres on 28/2/25.
//

import Foundation

actor CheckLogin {
    private let repository: LoginRepositoryType
    
    init(repository: LoginRepositoryType) {
        self.repository = repository
    }
    
    func execute() async -> Result<Login, LoginDomainError> {
        return await repository.checkLogin()
    }
}
