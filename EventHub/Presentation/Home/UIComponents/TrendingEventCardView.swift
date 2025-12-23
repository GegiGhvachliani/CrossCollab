//
//  TrendingEventCardView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 22.12.25.
//

import SwiftUI

struct TrendingEventCardView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // Image or placeholder
            if let imageUrl = event.imageUrl, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(12)
                } placeholder: {
                    placeholderImage
                }
                .frame(width: 170, height: 100)
                .clipped()
                .cornerRadius(12)
                .padding(.top, 5)
                .padding(.horizontal, 5)
            } else {
                placeholderImage
                    .frame(width: 170, height: 100)
                    .clipped()
                    .cornerRadius(12)
                    .padding(.top, 5)
                    .padding(.horizontal, 5)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(event.title)
                    .font(.headline)
                    .lineLimit(2)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                    Text(formatDate(event.startDateTime))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(8)
        }
        .frame(width: 180, height: 180)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private var placeholderImage: some View {
        Rectangle()
            .fill(Color.pink.opacity(0.4))
            .cornerRadius(12)
    }
    
    private func formatDate(_ dateString: String) -> String {
        let components = dateString.split(separator: "-")
        guard components.count >= 3 else { return "TBA" }
        let month = components[1]
        let day = components[2].split(separator: "T")[0]
        return "\(month)/\(day)"
    }
}
