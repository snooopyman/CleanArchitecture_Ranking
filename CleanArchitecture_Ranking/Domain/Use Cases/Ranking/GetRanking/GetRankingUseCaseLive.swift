//
//  GetRankingUseCaseLive.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 19/3/25.
//

actor GetRankingUseCaseLive: GetRankingUseCaseType {
    private let repository: GetRankingRepositoryType
    
    init(repository: GetRankingRepositoryType) {
        self.repository = repository
    }
    
    func execute() async -> Result<RankingModel, APIDomainError> {
        let result = await repository.getRanking()
        
        switch result {
        case .success(let rankingDTO):
            let rankingModel = RankingDTOMapper.map(rankingDTO)
            return .success(rankingModel)
        case .failure(let error):
            return .failure(error)
        }
    }
}
