//
//  DetailsView.swift
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
                    EventBanner(imageURL: event.imageUrl)
                    EventTags(tags: event.tags ?? [])
                    EventInfoSection(event: event)
                    Divider()
                    RegisterSection(event: event) {
                        viewModel.registerForEvent()
                    }
                    Divider()
                    AboutEventSection(description: event.description ?? "")
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








