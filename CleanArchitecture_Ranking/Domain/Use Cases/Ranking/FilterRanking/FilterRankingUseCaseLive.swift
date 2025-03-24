//
//  FilterRankingUseCaseLive.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 22/3/25.
//

import Foundation
import CoreLocation

class FilterRankingUseCaseLive: FilterRankingUseCaseType {
    private let userCountryCode: String = "ES"
    private let currentLocation: CLLocation = CLLocation(latitude: 40.4168, longitude: -3.7038)
    
    func execute(
        ranking: RankingModel,
        gender: GenderOption,
        levels: Set<LevelOption>,
        location: LocationOption,
        ageCategories: Set<AgeCategoryOption>
    ) -> RankingModel {
        let filteredByGender: (ExercisePowerLiftingModel) -> Bool = { exercise in
            switch gender {
            case .both:
                return true
            case .male, .female:
                return exercise.gender.lowercased() == gender.rawValue.lowercased()
            }
        }
        
        let filteredByLevel: (ExercisePowerLiftingModel) -> Bool = { exercise in
            return levels.isEmpty || levels.contains(LevelOption(rawValue: exercise.level.lowercased()) ?? .elite)
        }
        
        let filteredByAge: (ExercisePowerLiftingModel) -> Bool = { exercise in
            let birthDate = Date(timeIntervalSince1970: TimeInterval(exercise.birthDate))
            let age = self.calculateAge(from: birthDate)
            
            if ageCategories.isEmpty {
                return true
            }
            
            //            if ageCategories.contains(.subJunior) && age >= 14 && age <= 18 {
            if ageCategories.contains(.subJunior) && age <= 18 {
                return true
            }
            if ageCategories.contains(.junior) && age >= 19 && age <= 23 {
                return true
            }
            if ageCategories.contains(.open) && age >= 24 {
                return true
            }
            if ageCategories.contains(.masters) && age >= 40 {
                return true
            }
            
            return false
        }
        
        let filteredByLocation: (ExercisePowerLiftingModel) -> Bool = { exercise in
            switch location {
            case .world:
                return true
            case .national:
                return exercise.address.country.code.lowercased() == self.userCountryCode.lowercased()
            case .current:
                guard let userCoordinates = exercise.address.currentLocation else { return false }
                let userLocation = CLLocation(latitude: userCoordinates.latitude, longitude: userCoordinates.longitude)
                return self.isWithinRadius(userLocation, radius: 10)
            }
        }
        
        let applyExerciseFilters: ([String: ExercisePowerLiftingModel]) -> [String: ExercisePowerLiftingModel] = { exercises in
            return exercises.filter { (key, exercise) in
                filteredByGender(exercise) &&
                filteredByLevel(exercise) &&
                filteredByAge(exercise) &&
                filteredByLocation(exercise)
            }
        }
        
        let applyOfficialFilters: ([String: OfficialPowerLiftingModel]) -> [String: OfficialPowerLiftingModel] = { officials in
            return officials.filter { (key, official) in
                let birthDate = Date(timeIntervalSince1970: TimeInterval(official.birthDate))
                let age = self.calculateAge(from: birthDate)
                
                let genderMatch = (gender == .both || official.gender.lowercased() == gender.rawValue.lowercased())
                let levelMatch = levels.isEmpty || levels.contains(LevelOption(rawValue: official.level.lowercased()) ?? .elite)
                
                let ageMatch: Bool
                if ageCategories.isEmpty {
                    ageMatch = true
                } else {
                    //                    ageMatch = (ageCategories.contains(.subJunior) && age >= 14 && age <= 18) ||
                    ageMatch = (ageCategories.contains(.subJunior) && age <= 18) ||
                    (ageCategories.contains(.junior) && age >= 19 && age <= 23) ||
                    (ageCategories.contains(.open) && age >= 24) ||
                    (ageCategories.contains(.masters) && age >= 40)
                }
                
                let locationMatch: Bool
                switch location {
                case .world:
                    locationMatch = true
                case .national:
                    locationMatch = official.address.country.code.lowercased() == self.userCountryCode.lowercased()
                case .current:
                    guard let userCoordinates = official.address.currentLocation else { return false }
                    let userLocation = CLLocation(latitude: userCoordinates.latitude, longitude: userCoordinates.longitude)
                    locationMatch = self.isWithinRadius(userLocation, radius: 10)
                }
                
                return genderMatch && levelMatch && ageMatch && locationMatch
            }
        }
        
        let benchpress = applyExerciseFilters(ranking.powerlifting.benchpress)
        let deadlift = applyExerciseFilters(ranking.powerlifting.deadlift)
        let squat = applyExerciseFilters(ranking.powerlifting.squat)
        let pullup = applyExerciseFilters(ranking.powerlifting.pullup)
        let officialWilksRanking = applyOfficialFilters(ranking.powerlifting.officialWilksRanking)
        
        let filteredPowerlifting = PowerliftingRankingModel(
            benchpress: benchpress,
            deadlift: deadlift,
            pullup: pullup,
            squat: squat,
            officialWilksRanking: officialWilksRanking
        )
        
        let filteredRanking = RankingModel(
            powerlifting: filteredPowerlifting
        )
        
        return filteredRanking
    }
    
    private func calculateAge(from birthdate: Date) -> Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: Date())
        return ageComponents.year ?? 0
    }
    
    private func isWithinRadius(_ location: CLLocation, radius: Double) -> Bool {
        let distance = currentLocation.distance(from: location) / 1000
        return distance <= radius
    }
}
