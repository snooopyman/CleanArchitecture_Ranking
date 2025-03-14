//
//  AppState.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import Foundation

@Observable
final class AppState {
    var currentView: AppView = .login
    var isLoading: Bool = true
    
    enum AppView {
        case login
        case completeProfile
        case tabBar
    }
}
