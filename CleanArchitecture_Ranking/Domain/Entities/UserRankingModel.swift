//
//  UserRankingModel.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

struct UserRankingModel {
    let id: String
    let username: String
    let gender: String
    let address: AddressModel
    let birthDate: Int
    let level: String
    let profilePic: String?
    let maxLift: MeasurementModel?
    let wilksScore: Double
}
