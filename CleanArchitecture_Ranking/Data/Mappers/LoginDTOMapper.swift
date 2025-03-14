//
//  LoginDTOMapper.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

struct LoginDTOMapper {
    static func map(_ dto: LoginDTO) -> LoginModel {
        return LoginModel(isUserInApi: dto.isUserInApi)
    }
}
