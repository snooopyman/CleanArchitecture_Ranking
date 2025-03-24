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
    @State private var searchText: String = ""
    
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
                        let sortedRanking: [(key: String, user: UserRankingModel)] = {
                            switch ranking {
                            case .exercise(let exerciseRanking):
                                return exerciseRanking
                                    .sorted(by: { $0.value.wilksScore > $1.value.wilksScore })
                                    .map { (key: $0.key, user: UserRankingModel(
                                        id: $0.key,
                                        username: $0.value.username,
                                        gender: $0.value.gender, address: $0.value.address,
                                        birthDate: $0.value.birthDate, level: $0.value.level,
                                        profilePic: $0.value.profilePic,
                                        maxLift: $0.value.maxLift,
                                        wilksScore: $0.value.wilksScore
                                    )) }
                                
                            case .official(let officialRanking):
                                return officialRanking
                                    .sorted(by: { $0.value.totalWilksScore > $1.value.totalWilksScore })
                                    .map { (key: $0.key, user: UserRankingModel(
                                        id: $0.key,
                                        username: $0.value.username,
                                        gender: $0.value.gender, address: $0.value.address,
                                        birthDate: $0.value.birthDate, level: $0.value.level,
                                        profilePic: $0.value.profilePic,
                                        maxLift: nil,
                                        wilksScore: $0.value.totalWilksScore
                                    )) }
                            }
                        }()
                        
                        List {
                            ForEach(Array(sortedRanking.enumerated()), id: \.element.key) { index, element in
                                PowerLiftingRowView(
                                    user: element.user,
                                    index: index,
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
                        
                        if let currentUserRanking = viewModel.currentUserRanking,
                           let currentUserIndex = sortedRanking.firstIndex(where: { $0.key == currentUserRanking.id }) {
                            
                            PowerLiftingRowView(
                                user: currentUserRanking,
                                index: currentUserIndex,
                                backgroundColor: .gray
                            )
                            .cornerRadius(8)
                            .padding()
                        }
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
