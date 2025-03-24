//
//  UserProfileImage.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct UserProfileImage: View {
    var body: some View {
        Image(systemName: "person")
            .resizable()
            .clipShape(Circle())
            .frame(width: 50, height: 50)
            .foregroundStyle(.indigo)
    }
}
