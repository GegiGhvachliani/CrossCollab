//
//  CategoryCardView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 22.12.25.
//

import SwiftUI

struct CategoryCardView: View {
    let category: Category
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: category.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .foregroundColor(.black)
            
            Text(category.title)
                .font(.caption)
                .multilineTextAlignment(.center)
            
            Text("\(category.eventCount) events")
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .frame(width: 106, height: 122)
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
