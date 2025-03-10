//
//  CleanArchitecture_RankingApp.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import SwiftUI
import Firebase

@main
struct CleanArchitecture_RankingApp: App {
    @State private var appState = AppState()

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appState)
        }
    }
}



struct CompleteProfileView: View {
    var body: some View {
        Text("CompleteProfileView")
    }
}

struct TabBarView: View {
    var body: some View {
        Text("TabBarView")
    }
}
