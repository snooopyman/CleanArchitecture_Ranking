//
//  GetRankingRepositoryLive.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 19/3/25.
//

actor GetRankingRepositoryLive: GetRankingRepositoryType {
    private let apiDataSource: APIDataSourceType
    private let errorMapper: APIDomainErrorMapper
    
    init(apiDataSource: APIDataSourceType, errorMapper: APIDomainErrorMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
    }
    
    func getRanking() async -> Result<RankingDTO, APIDomainError> {
        let result = await apiDataSource.getRanking()
        
        switch result {
        case .success(let rankingDTO):
            return .success(rankingDTO)
        case .failure(let error):
            return .failure(errorMapper.map(error: error))
        }
    }
}
