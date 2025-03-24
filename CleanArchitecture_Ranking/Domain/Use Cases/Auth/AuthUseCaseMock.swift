//
//  AuthUseCaseMock.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

actor AuthUseCaseMock: AuthUseCaseType {
    func signInWithEmailPassword(withEmail email: String, password: String) async throws {
        // TODO: Need Implementation
    }
    
    func signInWithGoogle() async throws {
        // TODO: Need Implementation
    }
    
    func signInWithApple() async throws {
        // TODO: Need Implementation
    }
    
    func getCurrentUser() async -> FirebaseUserModel? {
        return FirebaseUserModel(uid: "wSyqUezFQeaFIN0Bzl3JygW7yRO2", email: "12@12.com")
    }
}
