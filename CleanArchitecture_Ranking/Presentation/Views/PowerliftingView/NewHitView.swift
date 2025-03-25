//
//  NewHitView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct NewHitView: View {
    var body: some View {
        Image(systemName: "plus")
            .padding(10)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 2)
    }
}
