//
//  ContentView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        Group {
            if appState.isLoading {
                ProgressView("Loading...")
            } else {
                switch appState.currentView {
                case .login:
                    LoginView(viewModel: viewModel)
                case .completeProfile:
                    CompleteProfileView()
                case .tabBar:
                    TabBarView()
                }
            }
        }
        .task {
            await viewModel.checkUserStatus()
            appState.isLoading = false
        }
    }
}
