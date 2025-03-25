//
//  SearchUserRankingUseCaseType.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 24/3/25.
//

protocol SearchUserRankingUseCaseType {
    func execute(searchText: String, in ranking: RankingModel) -> RankingModel?
}
