//
//  SearchUserRankingUseCaseType.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 24/3/25.
//

protocol SearchUserRankingUseCaseType {
    func execute(ranking: RankingModel, searchText: String) -> RankingModel
    func execute(ranking: PowerliftingRanking, searchText: String) -> PowerliftingRanking
}
