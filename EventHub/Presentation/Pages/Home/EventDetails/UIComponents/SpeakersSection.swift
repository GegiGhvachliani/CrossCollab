//
//  SpeakersSection.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 25.12.25.
//

import SwiftUI

struct SpeakersSection: View {
    let speakers: [Speaker]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Featured Speakers")
                .font(.system(size: 18, weight: .semibold))
            
            ForEach(speakers) { speaker in
                HStack(spacing: 12) {
                    AsyncImage(url: URL(string: speaker.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .foregroundColor(.secondary)
                    }
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(speaker.name)
                            .font(.system(size: 16, weight: .medium))
                        
                        Text(speaker.title)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                        
                        if let company = speaker.company {
                            Text(company)
                                .font(.system(size: 12))
                                .foregroundColor(.blue)
                        }
                        
                        if let bio = speaker.bio {
                            Text(bio)
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .padding(.horizontal)
    }
}
