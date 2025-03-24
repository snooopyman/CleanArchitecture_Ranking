//
//  AuthRepositoryLive.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 13/3/25.
//

import FirebaseAuth

actor AuthRepositoryLive: AuthRepositoryType {
    func signInWithEmailPassword(withEmail email: String, password: String) async throws {
        Task {
            Auth.auth().signIn(withEmail: email, password: password)
        }
    }
    
    func signInWithGoogle() async throws {
        //TODO: Need implementation
    }
    
    func signInWithApple() async throws {
        //TODO: Need implementation
    }
    
    func getCurrentUser() async -> FirebaseUserDTO? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        return FirebaseUserDTO(uid: user.uid, email: user.email)
    }
}
