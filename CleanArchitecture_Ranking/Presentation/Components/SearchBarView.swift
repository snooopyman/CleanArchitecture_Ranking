//
//  SearchBarView.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 23/3/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                if searchText.isEmpty {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        Text("Search")
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 10)
                }
                
                TextField("", text: $searchText)
                    .background(.clear)
            }
            .padding(10)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.clear)
            )
            .shadow(radius: 2)
        }
    }
}

#Preview {
    SearchBarView(searchText: .constant("snooopyman"))
}
