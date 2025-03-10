//
//  AuthService.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 1/3/25.
//

import FirebaseAuth

final class AuthService: AuthServiceType {
    func signInWithEmailPassword(withEmail email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signInWithGoogle() async throws {
        //
    }
    
    func signInWithApple() async throws {
        //
    }
}
