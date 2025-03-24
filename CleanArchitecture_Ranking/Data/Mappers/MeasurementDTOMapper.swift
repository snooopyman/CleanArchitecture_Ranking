//
//  MeasurementDTOMapper.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

struct MeasurementDTOMapper {
    static func map(_ dto: MeasurementDTO) -> MeasurementModel {
        return MeasurementModel(unit: dto.unit, value: dto.value)
    }
}
