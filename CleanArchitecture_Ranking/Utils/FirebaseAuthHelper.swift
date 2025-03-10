//
//  FirebaseAuthHelper.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import FirebaseAuth

final class FirebaseAuthHelper {
    private enum FirebaseAuthError: Error {
        case userNotAuthenticated
        case tokenError(Error)
    }
    
    static func getCurrentUserToken() async throws -> String {
        guard let user = Auth.auth().currentUser else {
            throw FirebaseAuthError.userNotAuthenticated
        }
        
        do {
            return try await user.getIDToken()
        } catch {
            throw FirebaseAuthError.tokenError(error)
        }
    }
    
    static func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
