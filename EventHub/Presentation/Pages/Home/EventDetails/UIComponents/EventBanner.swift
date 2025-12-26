//
//  EventBanner.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI

struct EventBanner: View {
    let imageURL: String?
    let eventId: Int
    
    var body: some View {
        AsyncImage(url: URL(string: finalImageUrl)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
        .frame(height: 200)
        .clipped()
    }
    
    private var finalImageUrl: String {
        imageURL ?? "https://picsum.photos/seed/event-\(eventId)/800/400"
    }
}
