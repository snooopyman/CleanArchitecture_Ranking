//
//  UserStatsView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct UserStatsView: View {
    let maxLift: String?
    let wilksScore: String?
    let isOfficialRanking: Bool
    
    var body: some View {
        VStack {
            if let maxLift = maxLift {
                Text(maxLift)
                    .bold()
                    .font(.title3)
            }
            
            if let wilksScore = wilksScore {
                if isOfficialRanking {
                    VStack {
                        Text(wilksScore)
                            .bold()
                            .font(.title3)
                        Text("Wilks")
                            .bold()
                            .font(.title3)
                    }
                } else {
                    Text(wilksScore)
                }
            }
        }
    }
}
