//
//  HomeView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 22.12.25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                ScrollView {
                    VStack( spacing: 24) {
                        
                        WelcomeSection(userName: viewModel.userName)
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .padding(.top, 50)
                        } else if let error = viewModel.errorMessage {
                            ErrorView(message: error) {
                                viewModel.loadEvents()
                            }
                        } else {
                            UpcomingEventsSection(events: Array(viewModel.events.prefix(3)))
                            
                            CategoriesSection(categories: viewModel.categories)
                            
                            TrendingSection(events: viewModel.trendingEvents)
                            
                            FAQSection()
                        }
                    }
                    .padding()
                }
            }
            .background(Color(.systemGray6).ignoresSafeArea())
            .refreshable {
                await viewModel.refreshEvents()
            }
            .onAppear {
                viewModel.loadEvents()
            }
        }
    }
}

// MARK: - Welcome Section
struct WelcomeSection: View {
    let userName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Welcome back, \(userName)")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Stay connected with upcoming company events and activities.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Upcoming Events Section
struct UpcomingEventsSection: View {
    let events: [Event]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Upcoming Events")
                    .font(.headline)
                Spacer()
                Text("View all")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            
            ForEach(events) { event in
                NavigationLink {
                    EventDetailsView(eventId: event.id)
                } label: {
                    EventCardView(event: event)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

// MARK: - Categories Section
struct CategoriesSection: View {
    let categories: [Category]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Browse by category")
                .font(.headline)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.fixed(106), spacing: 12), count: 3),
                spacing: 12
            ) {
                ForEach(categories) { category in
                    CategoryCardView(category: category)
                }
            }
        }
    }
}

// MARK: - Trending Section
struct TrendingSection: View {
    let events: [Event]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Trending Events")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(events) { event in
                        NavigationLink {
                            // TODO: Navigate to EventDetailView
                            EventDetailsView(eventId: event.id)
                        } label: {
                            TrendingEventCardView(event: event)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
}

// MARK: - FAQ Section
struct FAQSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Frequently Asked Questions")
                .font(.headline)
            
            Text("You can cancel your registration up to 24 hours before the event through this app. This will allow someone from the waitlist to attend.")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Error View
struct ErrorView: View {
    let message: String
    let retry: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.red)
            
            Text(message)w
                .font(.system(size: 16))
                .foregroundColor(.secondary)
            
            Button("Try Again") {
                retry()
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 12)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    HomeView(viewModel: DIContainer.shared.makeHomeViewModel())
}
