//
//  BrowseEventsList.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI


struct BrowseEventsList: View {
    let events: [Event]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(events) { event in
                    NavigationLink {
                        EventDetailsView(eventId: event.id)
                    } label: {
                        BrowseEventCard(event: event)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
    }
}
