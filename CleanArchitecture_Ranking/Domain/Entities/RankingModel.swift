//
//  RankingModel.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 19/3/25.
//

struct RankingModel {
    let powerlifting: PowerliftingRankingModel
}

enum PowerliftingRanking {
    case exercise([String: ExercisePowerLiftingModel])
    case official([String: OfficialPowerLiftingModel])
}

struct PowerliftingRankingModel {
    typealias ExerciseRankingModel = [String: ExercisePowerLiftingModel]
    typealias WilksRankingModel = [String: OfficialPowerLiftingModel]
    
    let benchpress: ExerciseRankingModel
    let deadlift: ExerciseRankingModel
    let pullup: ExerciseRankingModel
    let squat: ExerciseRankingModel
    let officialWilksRanking: WilksRankingModel
}

struct OfficialPowerLiftingModel {
    let address: AddressModel
    let birthDate: Int
    let gender: String
    let profilePic: String
    let username: String
    let level: String
    let totalWilksScore: Double
}

struct ExercisePowerLiftingModel {
    let address: AddressModel
    let birthDate: Int
    let gender: String
    let profilePic: String
    let username: String
    let level: String
    let maxLift: MeasurementModel
    let wilksScore: Double
}
