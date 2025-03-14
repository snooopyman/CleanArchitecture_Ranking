//
//  CleanArchitecture_RankingApp.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import SwiftUI
import Firebase

@main
struct CleanArchitecture_RankingApp: App {
    @State private var appState = AppState()
    private let authUseCase: AuthUseCaseType
    private let checkLoginUseCase: CheckLoginUseCaseType
    
    init() {
        FirebaseApp.configure()
        
        let authRepository = AuthRepositoryLive()
        self.authUseCase = AuthUseCaseLive(authRepository: authRepository)
        
        let loginRepository = LoginRepositoryLive(
            apiDataSource: APILoginDataSource(),
            errorMapper: LoginDomainErrorMapper()
        )
//        let loginRepository = LoginRepositoryMock()
        self.checkLoginUseCase = CheckLoginUseCaseLive(repository: loginRepository)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: LoginViewModel(
                    authUseCase: authUseCase,
                    checkLoginUseCase: checkLoginUseCase,
                    appState: appState
                )
            )
            .environment(appState)
        }
    }
}
