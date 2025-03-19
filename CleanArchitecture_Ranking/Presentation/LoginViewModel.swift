//
//  LoginViewModel.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import Foundation

@MainActor
@Observable
class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var errorMessage: String? = nil
    
    private let authUseCase: AuthUseCaseType
    private let checkLoginUseCase: CheckLoginUseCaseType
    private let appState: AppState
    
    init(
        authUseCase: AuthUseCaseType,
        checkLoginUseCase: CheckLoginUseCaseType,
        appState: AppState
    ) {
        self.authUseCase = authUseCase
        self.checkLoginUseCase = checkLoginUseCase
        self.appState = appState
    }
    
    func login() async {
        do {
            try await authUseCase.signInWithEmailPassword(withEmail: email, password: password)
            
            await checkUserStatus()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func loginWithGoogle() async {
        do {
            try await authUseCase.signInWithGoogle()
            
            await checkUserStatus()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func loginWithApple() async {
        do {
            try await authUseCase.signInWithApple()
            
            await checkUserStatus()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func checkUserStatus() async {
        guard await authUseCase.getCurrentUser() != nil else {
            appState.currentView = .login
            return
        }
        
        let result = await checkLoginUseCase.execute()
        
        switch result {
        case .success(let loginModel):
            appState.currentView = loginModel.isUserInApi ? .tabBar : .completeProfile
        case .failure:
            appState.currentView = .login
        }
    }
}
