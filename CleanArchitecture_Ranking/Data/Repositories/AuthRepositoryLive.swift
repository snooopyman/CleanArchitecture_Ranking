//
//  AuthRepositoryLive.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 13/3/25.
//

import Foundation
@preconcurrency import FirebaseAuth

actor AuthRepositoryLive: AuthRepositoryType {
//    private let auth: AuthRepositoryType
    
//    init(auth: AuthRepositoryType) {
//        self.auth = auth
//    }
//    
    func signInWithEmailPassword(withEmail email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signInWithGoogle() async throws {
//        try await auth.signInWithGoogle()
    }
    
    func signInWithApple() async throws {
//        try await auth.signInWithApple()
    }
}
