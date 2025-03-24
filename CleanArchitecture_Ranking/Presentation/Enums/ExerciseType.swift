//
//  ExerciseType.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 24/3/25.
//

enum ExerciseType: String, CaseIterable {
    case official
    case benchpress
    case squat
    case deadlift
    case pullup
    
    func format(as formatType: FormatType) -> String {
        switch formatType {
        case .title:
            switch self {
            case .official: return "Powerlifting"
            case .benchpress: return "Bench Press"
            case .squat: return "Squat"
            case .deadlift: return "Deadlift"
            case .pullup: return "Pullup"
            }
        case .mapping:
            switch self {
            case .official: return "official"
            case .benchpress: return "benchpress"
            case .squat: return "squat"
            case .deadlift: return "deadlift"
            case .pullup: return "pullup"
            }
        }
    }
}
