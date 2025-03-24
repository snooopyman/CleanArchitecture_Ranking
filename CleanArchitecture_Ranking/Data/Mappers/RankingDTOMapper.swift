//
//  RankingDTOMapper.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 19/3/25.
//

struct RankingDTOMapper {
    static func map(_ dto: RankingDTO) -> RankingModel {
        return RankingModel(
            powerlifting: PowerliftingRankingModel(
                benchpress: dto.powerlifting.benchpress.mapValues { ExercisePowerLiftingDTOMapper.map($0) },
                deadlift: dto.powerlifting.deadlift.mapValues { ExercisePowerLiftingDTOMapper.map($0) },
                pullup: dto.powerlifting.pullup.mapValues { ExercisePowerLiftingDTOMapper.map($0) },
                squat: dto.powerlifting.squat.mapValues { ExercisePowerLiftingDTOMapper.map($0) },
                officialWilksRanking: dto.powerlifting.officialWilksRanking.mapValues { OfficialPowerLiftingDTOMapper.map($0) }
            )
        )
    }
}

struct ExercisePowerLiftingDTOMapper {
    static func map(_ dto: ExercisePowerLiftingDTO) -> ExercisePowerLiftingModel {
        return ExercisePowerLiftingModel(
            address: AddressDTOMapper.map(dto.address),
            birthDate: dto.birthDate,
            gender: dto.gender,
            profilePic: dto.profilePic,
            username: dto.username,
            level: dto.level,
            maxLift: MeasurementDTOMapper.map(dto.maxLift),
            wilksScore: dto.wilksScore
        )
    }
}

struct OfficialPowerLiftingDTOMapper {
    static func map(_ dto: OfficialPowerLiftingDTO) -> OfficialPowerLiftingModel {
        return OfficialPowerLiftingModel(
            address: AddressDTOMapper.map(dto.address),
            birthDate: dto.birthDate,
            gender: dto.gender,
            profilePic: dto.profilePic,
            username: dto.username,
            level: dto.level,
            totalWilksScore: dto.totalWilksScore
        )
    }
}
