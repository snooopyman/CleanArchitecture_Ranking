//
//  SearchUserRankingUseCaseMock.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 24/3/25.
//

class SearchUserRankingUseCaseMock: SearchUserRankingUseCaseType {
    func execute(ranking: RankingModel, searchText: String) -> RankingModel {
        return ranking
    }
}
