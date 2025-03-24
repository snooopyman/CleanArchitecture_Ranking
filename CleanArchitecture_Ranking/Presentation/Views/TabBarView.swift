//
//  TabBarView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 13/3/25.
//

import SwiftUI

struct TabBarView: View {
    @State private var rankingViewModel: RankingViewModel
    
    init() {
        let authRepository = AuthRepositoryLive()
        let authUseCase = AuthUseCaseLive(authRepository: authRepository)
        
        let rankingRepository = GetRankingRepositoryLive(
            apiDataSource: APIDataSource(),
            errorMapper: APIDomainErrorMapper()
        )
        let getRankingUseCase = GetRankingUseCaseLive(repository: rankingRepository)
        
        let filterRankingUseCase = FilterRankingUseCaseLive()
        let getCurrentUserRankingUseCase = GetCurrentUserRankingUseCaseLive()
        let searchUserRankingUseCase = SearchUserRankingUseCaseLive()

        self._rankingViewModel = State(
            initialValue: RankingViewModel(
                getRankingUseCase: getRankingUseCase,
                authUseCase: authUseCase,
                filterRankingUseCase: filterRankingUseCase,
                getCurrentUserRankingUseCase: getCurrentUserRankingUseCase,
                searchUserRankingUseCase: searchUserRankingUseCase
            )
        )
    }
    
    var body: some View {
        TabView {
            PowerliftingView(viewModel: rankingViewModel)
                .tabItem {
                    Label("Powerlifting", systemImage: "dumbbell.fill")
                }
            
            Text("Comunidad")
                .tabItem {
                    Label("Comunidad", systemImage: "person.3.fill")
                }
            
            Text("Perfil")
                .tabItem {
                    Label("Perfil", systemImage: "person.fill")
                }
        }
    }
}
