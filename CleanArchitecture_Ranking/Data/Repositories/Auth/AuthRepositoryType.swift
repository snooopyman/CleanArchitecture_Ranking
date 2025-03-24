//
//  AuthRepositoryType.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 1/3/25.
//

protocol AuthRepositoryType: Sendable {
    func signInWithEmailPassword(withEmail email: String, password: String) async throws
    func signInWithGoogle() async throws
    func signInWithApple() async throws
    func getCurrentUser() async -> FirebaseUserDTO?
}
