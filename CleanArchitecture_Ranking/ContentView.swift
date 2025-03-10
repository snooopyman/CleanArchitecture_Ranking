//
//  ContentView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppState.self) private var appState
    @State private var isLoading = true
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView("...")
            } else {
                switch appState.currentView {
                case .login:
                    LoginView()
                case .completeProfile:
                    CompleteProfileView()
                case .tabBar:
                    TabBarView()
                }
            }
        }
        .task {
            await appState.checkUserStatus()
            isLoading = false
        }
    }
}
//struct ContentView: View {
//    @Environment(AppState.self) private var appState
//    
//    var body: some View {
//        Group {
//            switch appState.currentView {
//            case .login:
//                LoginView()
//            case .completeProfile:
//                CompleteProfileView()
//            case .tabBar:
//                TabBarView()
//            }
//        }
//        .task {
//            await appState.checkUserStatus()
//        }
//    }
//}

#Preview {
    ContentView()
}
