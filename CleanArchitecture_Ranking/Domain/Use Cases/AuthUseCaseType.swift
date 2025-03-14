//
//  AuthUseCaseType.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 13/3/25.
//

protocol AuthUseCaseType: Sendable {
    func signInWithEmailPassword(withEmail email: String, password: String) async throws
    func signInWithGoogle() async throws
    func signInWithApple() async throws
}
