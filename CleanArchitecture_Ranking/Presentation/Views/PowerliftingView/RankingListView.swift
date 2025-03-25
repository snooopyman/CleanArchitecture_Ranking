//
//  RankingListView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 25/3/25.
//

import SwiftUI

struct RankingListView: View {
    let viewModel: RankingViewModel
    let ranking: PowerliftingRanking
    let selectedExercise: ExerciseType
    
    var body: some View {
        let displayedRanking = viewModel.getDisplayedRanking(for: selectedExercise)
        
        List {
            ForEach(Array(displayedRanking.enumerated()), id: \.element.user.id) { _, element in
                PowerLiftingRowView(
                    user: element.user,
                    index: element.originalPosition,
                    backgroundColor: Color(.systemGray6)
                )
            }
        }
        .listStyle(PlainListStyle())
        .refreshable {
            Task {
                await viewModel.fetchRanking()
            }
        }
        
        Spacer()
        
        if let currentUser = viewModel.currentUserRanking,
           let userEntry = displayedRanking.first(where: { $0.user.id == currentUser.id }) {
            PowerLiftingRowView(
                user: userEntry.user,
                index: userEntry.originalPosition,
                backgroundColor: .gray
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()
        }
    }
}
