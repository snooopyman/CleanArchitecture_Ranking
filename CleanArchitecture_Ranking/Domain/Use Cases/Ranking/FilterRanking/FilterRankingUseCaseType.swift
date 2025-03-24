//
//  FilterRankingUseCaseType.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 22/3/25.
//

protocol FilterRankingUseCaseType {
    func execute(
        ranking: RankingModel,
        gender: GenderOption,
        levels: Set<LevelOption>,
        location: LocationOption,
        ageCategories: Set<AgeCategoryOption>
    ) -> RankingModel
}
