//
//  GetCurrentUserRankingUseCaseType.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 22/3/25.
//

protocol GetCurrentUserRankingUseCaseType {
    func execute(ranking: RankingModel, userId: String) -> UserRankingModel?
}
