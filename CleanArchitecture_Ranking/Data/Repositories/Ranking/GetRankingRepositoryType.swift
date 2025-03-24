//
//  GetRankingRepositoryType.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 19/3/25.
//

protocol GetRankingRepositoryType: Sendable {
    func getRanking() async -> Result<RankingDTO, APIDomainError>
}
