//
//  SearchUserRankingUseCaseMock.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 24/3/25.
//

class SearchUserRankingUseCaseMock: SearchUserRankingUseCaseType {
    func execute(searchText: String, in ranking: RankingModel) -> RankingModel? {
        return ranking
    }
}
