//
//  SearchUserRankingUseCaseLive.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 24/3/25.
//

class SearchUserRankingUseCaseLive: SearchUserRankingUseCaseType {
    func execute(searchText: String, in ranking: RankingModel) -> RankingModel? {
        guard !searchText.isEmpty else { return ranking }
        
        let lowercasedSearch = searchText.lowercased()
        
        func filterMaintainingOrder<T>(_ dict: [String: T], by username: (T) -> String) -> [String: T] {
            return dict.filter { entry in
                username(entry.value).lowercased().contains(lowercasedSearch)
            }
        }
        
        return RankingModel(
            powerlifting: PowerliftingRankingModel(
                benchpress: filterMaintainingOrder(ranking.powerlifting.benchpress) { $0.username },
                deadlift: filterMaintainingOrder(ranking.powerlifting.deadlift) { $0.username },
                pullup: filterMaintainingOrder(ranking.powerlifting.pullup) { $0.username },
                squat: filterMaintainingOrder(ranking.powerlifting.squat) { $0.username },
                officialWilksRanking: filterMaintainingOrder(ranking.powerlifting.officialWilksRanking) { $0.username }
            )
        )
    }
}
