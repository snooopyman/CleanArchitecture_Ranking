//
//  CountryInfoView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct CountryInfoView: View {
    let countryCode: String
    
    var body: some View {
        HStack {
            Image(countryCode.lowercased())
                .resizable()
                .clipShape(Circle())
                .frame(width: 12, height: 12)
            
            Text(countryCode)
                .font(.subheadline)
        }
    }
}

#Preview {
    CountryInfoView(countryCode: "ES")
}
