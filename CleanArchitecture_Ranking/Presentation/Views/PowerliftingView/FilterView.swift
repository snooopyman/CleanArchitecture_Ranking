//
//  FilterView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct FilterView: View {
    @State private var isFilterModalPresented = false
    @State private var filterModalHeight: CGFloat = 500
    
    @Bindable var viewModel: RankingViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "slider.horizontal.3")
                .padding(10)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 2)
                .onTapGesture {
                    isFilterModalPresented = true
                }
                .sheet(isPresented: $isFilterModalPresented) {
                    FilterModalView(
                        contentHeight: $filterModalHeight,
                        isPresented: $isFilterModalPresented,
                        viewModel: viewModel
                    )
                    .presentationDetents([.height(filterModalHeight)])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(20)
                }
        }
    }
}
