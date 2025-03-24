//
//  CheckLoginRepositoryLive.swift
//  PowerRanking
//
//  Created by Armando Cáceres on 28/2/25.
//

actor CheckLoginRepositoryLive: CheckLoginRepositoryType {
    private let apiDataSource: APIDataSourceType
    private let errorMapper: APIDomainErrorMapper
    
    init(apiDataSource: APIDataSourceType, errorMapper: APIDomainErrorMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
    }
    
    func checkLogin() async -> Result<LoginDTO, APIDomainError> {
        let result = await apiDataSource.login()
        
        switch result {
        case .success(let loginDTO):
            return .success(loginDTO)
        case .failure(let error):
            return .failure(errorMapper.map(error: error))
        }
    }
}
