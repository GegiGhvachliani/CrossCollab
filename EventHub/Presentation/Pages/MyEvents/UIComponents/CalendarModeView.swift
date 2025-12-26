//
//  CalendarModeView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 24.12.25.
//

import SwiftUI


struct CalendarModeView: View {
    @ObservedObject var viewModel: MyEventsViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                if let upcomingEvent = viewModel.upcomingEvent {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Upcoming Event")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        NextEventCard(registration: upcomingEvent)
                    }
                    
                    Divider()
                        .padding(.horizontal)
                }
                
                CalendarPicker(selectedDate: $viewModel.selectedDate)
                    .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Events on \(formattedDate(viewModel.selectedDate))")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    if viewModel.eventsForSelectedDate.isEmpty {
                        Text("No events on this day")
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                            .padding(.top, 8)
                    } else {
                        ForEach(viewModel.eventsForSelectedDate) { registration in
                            NavigationLink {
                                EventDetailsView(eventId: registration.eventId)
                            } label: {
                                EventDetailCard(registration: registration)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .background(Color(.systemGray6))
    }
    
    private func formattedDate(_ date: Date) -> String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
}
