//
//  FilterRankingUseCaseMock.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

class FilterRankingUseCaseMock: FilterRankingUseCaseType {
    func execute(ranking: RankingModel, gender: GenderOption, levels: Set<LevelOption>, location: LocationOption, ageCategories: Set<AgeCategoryOption>) -> RankingModel {
        return ranking
    }
}
