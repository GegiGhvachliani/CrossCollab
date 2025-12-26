//
//  SearchAndFilterBar.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI


struct SearchAndFilterBar: View {
    @Binding var searchText: String
    let onFilterTap: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search events", text: $searchText)
            }
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
            Button(action: onFilterTap) {
                HStack(spacing: 6) {
                    Image(systemName: "slider.horizontal.3")
                    Text("Filter")
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(Color.blue.opacity(0.1))
                .foregroundColor(.blue)
                .cornerRadius(10)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 12)
    }
}
