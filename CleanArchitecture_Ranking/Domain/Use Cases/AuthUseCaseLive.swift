//
//  AuthUseCaseLive.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 13/3/25.
//

import Foundation

actor AuthUseCaseLive: AuthUseCaseType {
    private let authRepository: AuthRepositoryType
    
    init(authRepository: AuthRepositoryType) {
        self.authRepository = authRepository
    }
    
    func signInWithEmailPassword(withEmail email: String, password: String) async throws {
        try await authRepository.signInWithEmailPassword(withEmail: email, password: password)
    }
    
    func signInWithGoogle() async throws {
        try await authRepository.signInWithGoogle()
    }
    
    func signInWithApple() async throws {
        try await authRepository.signInWithApple()
    }
}
