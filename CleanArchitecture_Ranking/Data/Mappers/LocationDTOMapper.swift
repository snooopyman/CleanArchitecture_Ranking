//
//  LocationDTOMapper.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

struct LocationDTOMapper {
    static func map(_ dto: LocationDTO) -> LocationModel {
        return LocationModel(latitude: dto.latitude, longitude: dto.longitude)
    }
}
