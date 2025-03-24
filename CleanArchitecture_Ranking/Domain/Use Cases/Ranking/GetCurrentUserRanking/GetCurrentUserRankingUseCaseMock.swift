//
//  GetCurrentUserRankingUseCaseMock.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

class GetCurrentUserRankingUseCaseMock: GetCurrentUserRankingUseCaseType {
    func execute(
        ranking: RankingModel,
        userId: String
    ) -> UserRankingModel? {
        return UserRankingModel(
            id: "123",
            username: "testuser",
            gender: "female",
            address: AddressModel(
                country: CountryModel(
                    code: "ES"
                ),
                currentLocation: LocationModel(
                    latitude: 212,
                    longitude: 123
                )
            ),
            birthDate: 123452,
            level: "advanced",
            profilePic: "https://example.com/profile.jpg",
            maxLift: MeasurementModel(
                unit: "kg",
                value: 100
            ),
            wilksScore: 50
        )
    }
}
