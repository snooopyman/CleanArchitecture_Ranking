//
//  PowerLiftingRowView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct PowerLiftingRowView: View {
    let user: UserRankingModel
    let index: Int
    let backgroundColor: Color
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                PositionIndexView(index: index)

                
                Spacer()
                
                LevelView()
                    .padding(.top, 8)
                    .padding(.trailing, 12)
            }
            
            HStack {
                VStack {
                    UserProfileImage()
                }
                
                VStack(alignment: .leading) {
                    UsernameView(username: user.username)
                    CountryInfoView(countryCode: user.address.country.code)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    if let maxLift = user.maxLift {
                        Text("\(maxLift.value) \(maxLift.unit)")
                            .font(.headline)
                    }
                    Text("Wilks: \(user.wilksScore)")
                        .font(.subheadline)
                }
                .padding(.bottom, 8)
                .padding(.horizontal, 12)
            }
        }
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.1), radius: 3)
    }
}
