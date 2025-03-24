//
//  ExerciseSelectionView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct ExerciseSelectionView: View {
    @Binding var selectedExercise: ExerciseType
    let exercises: [ExerciseType]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(exercises, id: \.self) { exercise in
                    Button(action: {
                        selectedExercise = exercise
                    }) {
                        ExerciseButton(selectedExercise: $selectedExercise, title: exercise.format(as: .title), exerciseType: exercise)
                    }
                }
            }
        }
    }
}
