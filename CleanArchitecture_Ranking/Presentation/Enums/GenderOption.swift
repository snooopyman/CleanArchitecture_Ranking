//
//  GenderOption.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 24/3/25.
//

enum GenderOption: String {
    case male
    case female
    case both
    
    static func from(rawValue: String?) -> GenderOption {
        guard let value = rawValue else { return .both }
        return GenderOption(rawValue: value) ?? .both
    }
}
