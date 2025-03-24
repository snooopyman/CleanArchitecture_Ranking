//
//  AddressDTOMapper.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

struct AddressDTOMapper {
    static func map(_ dto: AddressDTO) -> AddressModel {
        return AddressModel(
            country: CountryDTOMapper.map(dto.country),
            currentLocation: dto.currentLocation.map { LocationDTOMapper.map($0) }
        )
    }
}
