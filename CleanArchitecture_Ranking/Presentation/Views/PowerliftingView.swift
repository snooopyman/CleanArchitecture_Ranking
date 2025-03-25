//
//  PowerliftingView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct PowerliftingView: View {
    @State private var viewModel: RankingViewModel
    @State private var selectedExercise: ExerciseType = .benchpress
    
    init(viewModel: RankingViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ExerciseSelectionView(
                    selectedExercise: $selectedExercise,
                    exercises: ExerciseType.allCases
                )
                .padding(.top, 30)
                
                HStack {
                    SearchBarView(searchText: $viewModel.searchText)
                    FilterView(viewModel: viewModel)
                    NewHitView()
                }
                
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Cargando...")
                    } else if let errorMessage = viewModel.error {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    } else if let ranking = viewModel.getRanking(for: selectedExercise) {
                        RankingListView(
                            viewModel: viewModel,
                            ranking: ranking,
                            selectedExercise: selectedExercise
                        )
                    }
                }
            }
            .navigationTitle("Powerlifting")
            .task {
                await viewModel.fetchRanking()
            }
        }
    }
}

#Preview {
    let httpClient = URLSessionHTTPClient()
    let apiDataSource = APIDataSource(httpClient: httpClient)
    let authRepository = AuthRepositoryLive()
    let rankingRepository = GetRankingRepositoryLive(apiDataSource: apiDataSource, errorMapper: APIDomainErrorMapper())
    
    let getRankingUseCase = GetRankingUseCaseLive(repository: rankingRepository)
    let authUseCase = AuthUseCaseLive(authRepository: authRepository)
    let filterRankingUseCase = FilterRankingUseCaseLive()
    let getCurrentUserRankingUseCase = GetCurrentUserRankingUseCaseLive()
    let searchUserRankingUseCase = SearchUserRankingUseCaseLive()
    
    let liveViewModel = RankingViewModel(
        getRankingUseCase: getRankingUseCase,
        authUseCase: authUseCase,
        filterRankingUseCase: filterRankingUseCase,
        getCurrentUserRankingUseCase: getCurrentUserRankingUseCase,
        searchUserRankingUseCase: searchUserRankingUseCase
    )
    
    return PowerliftingView(viewModel: liveViewModel)
}
