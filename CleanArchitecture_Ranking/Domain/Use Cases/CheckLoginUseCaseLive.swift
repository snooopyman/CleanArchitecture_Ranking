//
//  CheckLoginUseCaseLive.swift
//  PowerRanking
//
//  Created by Armando Cáceres on 28/2/25.
//

import Foundation

actor CheckLoginUseCaseLive: CheckLoginUseCaseType {
    private let repository: LoginRepositoryType
    
    init(repository: LoginRepositoryType) {
        self.repository = repository
    }
    
    func execute() async -> Result<LoginModel, LoginDomainError> {
        let result = await repository.checkLogin()
        
        switch result {
        case .success(let loginDTO):
            let loginModel = LoginDTOMapper.map(loginDTO)
            return .success(loginModel)
        case .failure(let error):
            return .failure(error)
        }
    }
}
