//
//  RankingDTO.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 19/3/25.
//

struct RankingDTO: Codable {
    let powerlifting: PowerliftingRankingDTO
}

struct PowerliftingRankingDTO: Codable {
    typealias ExerciseRankingDTO = [String: ExercisePowerLiftingDTO]
    typealias WilksRankingDTO = [String: OfficialPowerLiftingDTO]
    
    let benchpress: ExerciseRankingDTO
    let deadlift: ExerciseRankingDTO
    let pullup: ExerciseRankingDTO
    let squat: ExerciseRankingDTO
    let officialWilksRanking: WilksRankingDTO
}

struct OfficialPowerLiftingDTO: Codable {
    let address: AddressDTO
    let birthDate: Int
    let gender: String
    let level: String
    let profilePic: String
    let username: String
    let totalWilksScore: Double
}

struct ExercisePowerLiftingDTO: Codable {
    let address: AddressDTO
    let birthDate: Int
    let gender: String
    let level: String
    let profilePic: String
    let username: String
    let maxLift: MeasurementDTO
    let wilksScore: Double
}
