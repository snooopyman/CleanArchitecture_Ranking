//
//  CountryDTOMapper.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

struct CountryDTOMapper {
    static func map(_ dto: CountryDTO) -> CountryModel {
        return CountryModel(code: dto.code)
    }
}
