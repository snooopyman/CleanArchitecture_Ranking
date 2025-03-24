//
//  GetRankingUseCaseType.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 19/3/25.
//

protocol GetRankingUseCaseType: Sendable {
    func execute() async -> Result<RankingModel, APIDomainError>
}
