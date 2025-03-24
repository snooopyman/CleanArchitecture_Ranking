//
//  PositionIndexView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct PositionIndexView: View {
    let index: Int
    
    var body: some View {
        Text("\(index + 1)")
            .font(.system(size: 12))
            .foregroundColor(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(backgroundColor(for: index))
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
    
    func backgroundColor(for index: Int) -> Color {
        switch index {
        case 0:
            return .orange
        case 1:
            return .gray
        case 2:
            return .brown
        default:
            return .blue
        }
    }
}
