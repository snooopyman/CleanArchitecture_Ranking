//
//  AppState.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import Foundation
import FirebaseAuth

@Observable
final class AppState {
    var currentView: AppView = .login
    
    private let checkLogin: CheckLogin

    enum AppView {
        case login
        case completeProfile
        case tabBar
    }
    
    
    init(checkLogin: CheckLogin = CheckLogin(repository: LoginRepository(apiDataSource: APILoginDataSource(), errorMapper: LoginDomainErrorMapper()))) {
        self.checkLogin = checkLogin
    }
    
    @MainActor
    func checkUserStatus() async {
        guard Auth.auth().currentUser != nil else {
            currentView = .login
            return
        }
        
        let result = await checkLogin.execute()
        
        switch result {
        case .success(let login):
            currentView = login.isUserInApi ? .tabBar : .completeProfile
        case .failure:
            currentView = .login
        }
    }
}
