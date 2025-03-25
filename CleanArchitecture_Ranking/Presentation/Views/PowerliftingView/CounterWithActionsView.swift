//
//  CounterWithActionsView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 22/3/25.
//

import SwiftUI

struct CounterWithActionsView: View {
    @Binding var selectedLevel: LevelOption
    var counterUsers: Int
    
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
            Text("\(counterUsers)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    SelectionButton(option: .elite, selectedOption: $selectedLevel)
                        .padding(10)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    SelectionButton(option: .advanced, selectedOption: $selectedLevel)
                        .padding(10)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    SelectionButton(option: .middle, selectedOption: $selectedLevel)
                        .padding(10)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    SelectionButton(option: .noob, selectedOption: $selectedLevel)
                        .padding(10)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}

#Preview {
    CounterWithActionsView(selectedLevel: .constant(.advanced), counterUsers: 10)
}
