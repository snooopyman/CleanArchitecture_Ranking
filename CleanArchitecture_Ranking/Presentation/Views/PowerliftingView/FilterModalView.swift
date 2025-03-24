//
//  FilterModalView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct FilterModalView: View {
    @Binding var contentHeight: CGFloat
    @Binding var isPresented: Bool
    
    @Bindable var viewModel: RankingViewModel
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Toggle("Wilks", isOn: $viewModel.isWilkActive)
                    .font(.headline)
                
                Text("Location")
                    .font(.headline)
                HStack {
                    SelectionButton(option: .world, selectedOption: $viewModel.selectedLocation)
                    SelectionButton(option: .national, selectedOption: $viewModel.selectedLocation)
                    SelectionButton(option: .current, selectedOption: $viewModel.selectedLocation)
                }
                
                Text("Levels")
                    .font(.headline)
                LazyVGrid(columns: columns, alignment: .leading) {
                    ForEach(LevelOption.allCases, id: \.self) { level in
                        Toggle(level.rawValue, isOn: Binding(
                            get: { viewModel.selectedLevels.contains(level) },
                            set: { isSelected in
                                if isSelected {
                                    viewModel.selectedLevels.insert(level)
                                } else {
                                    viewModel.selectedLevels.remove(level)
                                }
                            }
                        ))
                    }
                }
                .toggleStyle(CheckboxToggleStyle())
                
                Text("Age")
                    .font(.headline)
                VStack(alignment: .leading) {
                    ForEach(AgeCategoryOption.allCases, id: \.self) { ageCategory in
                        Toggle(ageCategory.rawValue, isOn: Binding(
                            get: { viewModel.selectedAgeCategories.contains(ageCategory) },
                            set: { isSelected in
                                if isSelected {
                                    viewModel.selectedAgeCategories.insert(ageCategory)
                                } else {
                                    viewModel.selectedAgeCategories.remove(ageCategory)
                                }
                            }
                        ))
                    }
                }
                .toggleStyle(CheckboxToggleStyle())
                
                Text("Gender")
                    .font(.headline)
                HStack {
                    SelectionButton(option: .male, selectedOption: $viewModel.selectedGender)
                    SelectionButton(option: .female, selectedOption: $viewModel.selectedGender)
                    SelectionButton(option: .both, selectedOption: $viewModel.selectedGender)
                }
            }
            .padding()
            .background(
                GeometryReader { innerGeometry in
                    Color.clear
                        .onAppear {
                            contentHeight = innerGeometry.size.height + 108 //toolbar: 56, title: 52
                        }
                }
            )
            .navigationTitle("Filters")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        applyFilters()
                        isPresented = false
                    }
                }
            }
        }
    }
    
    private func applyFilters() {
        Task {
            await viewModel.applyFilters()
        }
    }
}
