//
//  GetRankingUseCaseMock.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import Foundation

actor GetRankingUseCaseMock: GetRankingUseCaseType {
    func execute() async -> Result<RankingModel, APIDomainError> {
        let rankingDTO = RankingModel(
            powerlifting: PowerliftingRankingModel(
                benchpress: [:],
                deadlift: [:],
                pullup: [:],
                squat: [:],
                officialWilksRanking: [:]
            )
        )
        return .success(rankingDTO)
    }
}
