//
//  GetCurrentUserRankingUseCaseLive.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 22/3/25.
//

class GetCurrentUserRankingUseCaseLive: GetCurrentUserRankingUseCaseType {
    func execute(ranking: RankingModel, userId: String) -> UserRankingModel? {
        if let user = ranking.powerlifting.officialWilksRanking[userId] {
            return UserRankingModel(
                id: userId,
                username: user.username,
                gender: user.gender,
                address: user.address,
                birthDate: user.birthDate,
                level: user.level,
                profilePic: user.profilePic,
                maxLift: nil,
                wilksScore: user.totalWilksScore
            )
        }
        
        for exercise in [ranking.powerlifting.benchpress, ranking.powerlifting.deadlift, ranking.powerlifting.squat, ranking.powerlifting.pullup] {
            if let user = exercise[userId] {
                return UserRankingModel(
                    id: userId,
                    username: user.username,
                    gender: user.gender,
                    address: user.address,
                    birthDate: user.birthDate,
                    level: user.level,
                    profilePic: user.profilePic,
                    maxLift: user.maxLift,
                    wilksScore: user.wilksScore
                )
            }
        }
        
        return nil
    }
}
