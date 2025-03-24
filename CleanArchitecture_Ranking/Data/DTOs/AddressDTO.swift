//
//  AddressDTO.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

struct AddressDTO: Codable {
    let country: CountryDTO
    let currentLocation: LocationDTO?
}
