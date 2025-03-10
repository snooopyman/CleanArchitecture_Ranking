//
//  LoginDTOMapper.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

struct LoginDTOMapper {
    static func map(_ dto: LoginDTO) -> Login {
        return Login(isUserInApi: dto.isUserInApi)
    }
}
