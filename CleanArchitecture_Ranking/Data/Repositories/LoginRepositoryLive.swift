//
//  LoginRepository.swift
//  PowerRanking
//
//  Created by Armando Cáceres on 28/2/25.
//

import Foundation

actor LoginRepositoryLive: LoginRepositoryType {
    private let apiDataSource: APIDataSourceType
    private let errorMapper: LoginDomainErrorMapper
    
    init(apiDataSource: APIDataSourceType, errorMapper: LoginDomainErrorMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
    }
    
    func checkLogin() async -> Result<LoginDTO, LoginDomainError> {
        let result = await apiDataSource.login()
        
        switch result {
        case .success(let loginDTO):
            return .success(loginDTO)
        case .failure(let error):
            return .failure(errorMapper.map(error: error))
        }
    }
}
