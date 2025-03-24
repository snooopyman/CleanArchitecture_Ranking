//
//  LevelView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct LevelView: View {
    var body: some View {
        // FIXME: make the text dynamic
        Text("ELITE")
            .font(.system(size: 12))
            .foregroundColor(.white)
            .padding(.vertical, 2)
            .padding(.horizontal, 4)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
    LevelView()
}
