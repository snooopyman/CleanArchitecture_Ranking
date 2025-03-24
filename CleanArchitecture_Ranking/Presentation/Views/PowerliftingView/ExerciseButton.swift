//
//  ExerciseButton.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct ExerciseButton: View {
    @Binding var selectedExercise: ExerciseType
    
    let title: String
    let exerciseType: ExerciseType
    
    var body: some View {
        Button(action: {
            selectedExercise = exerciseType
        }) {
            VStack {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.black)
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(selectedExercise == exerciseType ? .purple : .clear)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
