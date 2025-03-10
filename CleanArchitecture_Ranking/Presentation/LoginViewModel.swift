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
    
    private let authService: AuthServiceType
    
    init(authService: AuthServiceType = AuthService()) {
        self.authService = authService
    }
    
    func login() async {
        do {
            try await authService.signInWithEmailPassword(withEmail: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
