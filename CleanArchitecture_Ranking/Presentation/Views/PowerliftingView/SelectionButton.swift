//
//  SelectionButton.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct SelectionButton<OptionType: Equatable>: View {
    let option: OptionType
    @Binding var selectedOption: OptionType
    
    var optionText: String {
        if let locationOption = option as? LocationOption {
            return locationOption.rawValue
        } else if let genderOption = option as? GenderOption {
            return genderOption.rawValue
        } else if let levelOption = option as? LevelOption {
            return levelOption.rawValue
        } else {
            return ""
        }
    }
    
    var body: some View {
        Text(optionText)
            .padding(8)
            .frame(maxWidth: .infinity)
            .background(.gray.opacity(0.2))
            .foregroundColor(selectedOption == option ? .black : .black.opacity(0.6))
            .clipShape(.rect(cornerRadius: 4))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(selectedOption == option ? .black : .clear, lineWidth: 1)
            )
            .onTapGesture {
                selectedOption = option
            }
    }
}
