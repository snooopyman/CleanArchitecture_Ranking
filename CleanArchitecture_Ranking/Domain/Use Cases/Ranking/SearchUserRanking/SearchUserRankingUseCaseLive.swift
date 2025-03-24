//
//  SearchUserRankingUseCaseLive.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 24/3/25.
//

class SearchUserRankingUseCaseLive: SearchUserRankingUseCaseType {
    func execute(ranking: RankingModel, searchText: String) -> RankingModel {
        guard !searchText.isEmpty else { return ranking }
        
        let lowercasedSearch = searchText.lowercased()
        
        let filteredBenchpress = ranking.powerlifting.benchpress.filter {
            $0.value.username.lowercased().contains(lowercasedSearch)
        }
        
        let filteredDeadlift = ranking.powerlifting.deadlift.filter {
            $0.value.username.lowercased().contains(lowercasedSearch)
        }
        
        let filteredSquat = ranking.powerlifting.squat.filter {
            $0.value.username.lowercased().contains(lowercasedSearch)
        }
        
        let filteredPullup = ranking.powerlifting.pullup.filter {
            $0.value.username.lowercased().contains(lowercasedSearch)
        }
        
        let filteredOfficial = ranking.powerlifting.officialWilksRanking.filter {
            $0.value.username.lowercased().contains(lowercasedSearch)
        }
        
        return RankingModel(
            powerlifting: PowerliftingRankingModel(
                benchpress: filteredBenchpress,
                deadlift: filteredDeadlift,
                pullup: filteredPullup,
                squat: filteredSquat,
                officialWilksRanking: filteredOfficial
            )
        )
    }
    
    func execute(ranking: PowerliftingRanking, searchText: String) -> PowerliftingRanking {
            guard !searchText.isEmpty else { return ranking }
            
            let lowercasedSearch = searchText.lowercased()
            
            switch ranking {
            case .exercise(let exercises):
                let filtered = exercises.filter {
                    $0.value.username.lowercased().contains(lowercasedSearch)
                }
                return .exercise(filtered)
                
            case .official(let officials):
                let filtered = officials.filter {
                    $0.value.username.lowercased().contains(lowercasedSearch)
                }
                return .official(filtered)
            }
        }
}
