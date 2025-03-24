//
//  RankingViewModel.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 19/3/25.
//

import Foundation

@MainActor
@Observable
class RankingViewModel {
    private let getRankingUseCase: GetRankingUseCaseType
    private let authUseCase: AuthUseCaseType
    private let filterRankingUseCase: FilterRankingUseCaseType
    private let getCurrentUserRankingUseCase: GetCurrentUserRankingUseCaseType
    private let searchUserRankingUseCase: SearchUserRankingUseCaseType
    
    var ranking: RankingModel?
    var filteredRanking: RankingModel?
    var currentUserRanking: UserRankingModel?
    var isLoading: Bool = false
    var error: String? = nil
    var searchText: String = "" {
        didSet {
            Task {
                await applySearch()
            }
        }
    }
    var searchedRanking: PowerliftingRanking?
    
    var selectedGender: GenderOption = .both
    var selectedLevels: Set<LevelOption> = []
    var selectedLocation: LocationOption = .world
    var selectedAgeCategories: Set<AgeCategoryOption> = []
    var isWilkActive: Bool = false
    
    init(
        getRankingUseCase: GetRankingUseCaseType,
        authUseCase: AuthUseCaseType,
        filterRankingUseCase: FilterRankingUseCaseType,
        getCurrentUserRankingUseCase: GetCurrentUserRankingUseCaseType,
        searchUserRankingUseCase: SearchUserRankingUseCaseType
    ) {
        self.getRankingUseCase = getRankingUseCase
        self.authUseCase = authUseCase
        self.filterRankingUseCase = filterRankingUseCase
        self.getCurrentUserRankingUseCase = getCurrentUserRankingUseCase
        self.searchUserRankingUseCase = searchUserRankingUseCase
    }
    
    func fetchRanking() async {
        isLoading = true
        error = nil
        
        let result = await getRankingUseCase.execute()
        
        switch result {
        case .success(let rankingModel):
            self.ranking = rankingModel
            await applyFilters()
        case .failure(let error):
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    private func applySearch() async {
        guard let ranking = ranking else { return }
        filteredRanking = searchUserRankingUseCase.execute(
            ranking: ranking,
            searchText: searchText
        )
        
        if let currentUser = await authUseCase.getCurrentUser(),
           let filteredRanking = filteredRanking {
            currentUserRanking = getCurrentUserRankingUseCase.execute(
                ranking: filteredRanking,
                userId: currentUser.uid
            )
        }
    }
    
    func applyFilters() async {
        guard let ranking = ranking else { return }
        filteredRanking = filterRankingUseCase.execute(
            ranking: ranking,
            gender: selectedGender,
            levels: selectedLevels,
            location: selectedLocation,
            ageCategories: selectedAgeCategories
        )
        
        if let currentUser = await authUseCase.getCurrentUser(),
           let filteredRanking = filteredRanking {
            let currentUserId = currentUser.uid
            currentUserRanking = getCurrentUserRankingUseCase.execute(
                ranking: filteredRanking,
                userId: currentUserId
            )
        }
    }
    
    func getRanking(for exercise: ExerciseType) -> PowerliftingRanking? {
        guard let ranking = filteredRanking else { return nil }
        
        switch exercise {
        case .benchpress:
            return .exercise(ranking.powerlifting.benchpress)
        case .deadlift:
            return .exercise(ranking.powerlifting.deadlift)
        case .squat:
            return .exercise(ranking.powerlifting.squat)
        case .pullup:
            return .exercise(ranking.powerlifting.pullup)
        case .official:
            return .official(ranking.powerlifting.officialWilksRanking)
        }
    }
}
