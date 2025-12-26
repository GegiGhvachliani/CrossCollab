//
//  EventDetailsView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI

struct EventDetailsView: View {
    @StateObject private var viewModel: EventDetailViewModel
    
    init(eventId: Int) {
        _viewModel = StateObject(
            wrappedValue: DIContainer.shared.makeEventDetailViewModel(eventId: eventId)
        )
    }
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .padding(.top, 100)
                
            } else if let error = viewModel.errorMessage {
                ErrorView(message: error) {
                    viewModel.loadEventDetail()
                }
                
            } else if let event = viewModel.event {
                VStack(alignment: .leading, spacing: 20) {
                    EventBanner(imageURL: event.imageUrl, eventId: event.id)
                    EventTags(tags: event.tags ?? [])
                    EventInfoSection(event: event)
                    Divider()
                    RegisterSection(event: event, viewModel: viewModel)
                    Divider()
                    AboutEventSection(description: event.description ?? "")
                    
                    if let agenda = viewModel.agenda, !agenda.isEmpty {
                          Divider()
                          AgendaSection(items: agenda)
                      }
                      
                      if let speakers = viewModel.speakers, !speakers.isEmpty {
                          Divider()
                          SpeakersSection(speakers: speakers)
                      }
                    
                    Divider()
                    FAQPlaceholder()
                }
            }
        }
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadEventDetail()
        }
    }
}
