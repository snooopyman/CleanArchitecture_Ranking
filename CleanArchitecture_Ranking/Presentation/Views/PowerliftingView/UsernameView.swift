//
//  UsernameView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct UsernameView: View {
    let username: String
    
    var body: some View {
        Text(username)
            .font(.headline)
    }
}
