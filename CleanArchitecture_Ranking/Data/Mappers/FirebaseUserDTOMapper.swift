//
//  FirebaseUserDTOMapper.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 19/3/25.
//

struct FirebaseUserDTOMapper {
    static func map(_ dto: FirebaseUserDTO) -> FirebaseUserModel {
        return FirebaseUserModel(uid: dto.uid, email: dto.email)
    }
}
