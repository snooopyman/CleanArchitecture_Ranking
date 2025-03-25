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
    
    // Datos
    var ranking: RankingModel?
    var filteredRanking: RankingModel?
    var currentUserRanking: UserRankingModel?
    private var lastFilteredRanking: RankingModel?
    private var fullSortedRankingCache: [ExerciseType: [(key: String, user: UserRankingModel)]] = [:]
    
    // Estados
    var isLoading: Bool = false
    var error: String?
    
    // Filtros
    var selectedGender: GenderOption = .both {
        didSet { Task { await applyFilters() } }
    }
    var selectedLevels: Set<LevelOption> = [] {
        didSet { Task { await applyFilters() } }
    }
    var selectedLocation: LocationOption = .world {
        didSet { Task { await applyFilters() } }
    }
    var selectedAgeCategories: Set<AgeCategoryOption> = [] {
        didSet { Task { await applyFilters() } }
    }
    var isWilkActive: Bool = false
    
    var searchText: String = "" {
        didSet {
            guard searchText != oldValue else { return }
            Task { await searchUser(searchText: searchText) }
        }
    }
    
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
    
    func applyFilters() async {
        guard let ranking = ranking else { return }
        
        let filtered = filterRankingUseCase.execute(
            ranking: ranking,
            gender: selectedGender,
            levels: selectedLevels,
            location: selectedLocation,
            ageCategories: selectedAgeCategories
        )
        
        self.lastFilteredRanking = filtered
        
        if !searchText.isEmpty {
            self.filteredRanking = searchUserRankingUseCase.execute(
                searchText: searchText,
                in: filtered
            )
        } else {
            self.filteredRanking = filtered
        }
        
        await updateCurrentUserRanking()
    }
    
    func searchUser(searchText: String) async {
        guard !searchText.isEmpty else {
            self.filteredRanking = lastFilteredRanking ?? ranking
            await updateCurrentUserRanking()
            return
        }
        
        guard let baseRanking = lastFilteredRanking ?? ranking else { return }
        
        self.filteredRanking = searchUserRankingUseCase.execute(
            searchText: searchText,
            in: baseRanking
        )
        
        await updateCurrentUserRanking()
    }
    
    private func updateCurrentUserRanking() async {
        if let currentUser = await authUseCase.getCurrentUser(),
           let filteredRanking = filteredRanking {
            currentUserRanking = getCurrentUserRankingUseCase.execute(
                ranking: filteredRanking,
                userId: currentUser.uid
            )
        } else {
            currentUserRanking = nil
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
    
    func getFilteredKeys(for exercise: ExerciseType) -> Set<String> {
        guard let filteredRanking = filteredRanking else { return Set() }
        
        switch exercise {
        case .benchpress:
            return Set(filteredRanking.powerlifting.benchpress.keys)
        case .deadlift:
            return Set(filteredRanking.powerlifting.deadlift.keys)
        case .squat:
            return Set(filteredRanking.powerlifting.squat.keys)
        case .pullup:
            return Set(filteredRanking.powerlifting.pullup.keys)
        case .official:
            return Set(filteredRanking.powerlifting.officialWilksRanking.keys)
        }
    }
    
    func getFullSortedRanking(for exercise: ExerciseType) -> [(key: String, user: UserRankingModel)] {
        if let cached = fullSortedRankingCache[exercise] {
            return cached
        }
        
        guard ranking != nil else { return [] }
        
        let sorted: [(key: String, user: UserRankingModel)] = {
            switch getRanking(for: exercise) {
            case .exercise(let exerciseRanking):
                return exerciseRanking
                    .sorted(by: { $0.value.wilksScore > $1.value.wilksScore })
                    .map { (key: $0.key, user: UserRankingModel(
                        id: $0.key,
                        username: $0.value.username,
                        gender: $0.value.gender,
                        address: $0.value.address,
                        birthDate: $0.value.birthDate,
                        level: $0.value.level,
                        profilePic: $0.value.profilePic,
                        maxLift: $0.value.maxLift,
                        wilksScore: $0.value.wilksScore
                    ))}
                
            case .official(let officialRanking):
                return officialRanking
                    .sorted(by: { $0.value.totalWilksScore > $1.value.totalWilksScore })
                    .map { (key: $0.key, user: UserRankingModel(
                        id: $0.key,
                        username: $0.value.username,
                        gender: $0.value.gender,
                        address: $0.value.address,
                        birthDate: $0.value.birthDate,
                        level: $0.value.level,
                        profilePic: $0.value.profilePic,
                        maxLift: nil,
                        wilksScore: $0.value.totalWilksScore
                    ))}
            case .none:
                return []
            }
        }()
        
        fullSortedRankingCache[exercise] = sorted
        return sorted
    }
    
    func getDisplayedRanking(for exercise: ExerciseType) -> [(user: UserRankingModel, originalPosition: Int)] {
        let fullRanking = getFullSortedRanking(for: exercise)
        let filteredKeys = getFilteredKeys(for: exercise)
        
        return fullRanking
            .enumerated()
            .filter { filteredKeys.contains($0.element.key) }
            .map { (user: $0.element.user, originalPosition: $0.offset) }
    }
}
