//
//  HomeView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 22.12.25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel 
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        WelcomeSection(userName: UserDefaults.standard.string(forKey: "fullName") ?? "User")
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .padding(.top, 50)
                        } else if let error = viewModel.errorMessage {
                            ErrorView(message: error) {
                                viewModel.loadEvents()
                            }
                        } else {
                            UpcomingEventsSection(events: Array(viewModel.events.prefix(3)))
                            
                            CategoriesSection(categories: viewModel.categorizedEvents)
                            
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
                if viewModel.events.isEmpty && !viewModel.isLoading {
                    viewModel.loadEvents()
                }
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
                NavigationLink {
                    BrowseView(viewModel: DIContainer.shared.makeBrowseViewModel())
                } label: {
                    Text("View all")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
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
    let categories: [(category: String, events: [Event])]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Browse by category")
                .font(.headline)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.fixed(106), spacing: 12), count: 3),
                spacing: 12
            ) {
                ForEach(categories, id: \.category) { category in
                    CategoryCardView(category: Category(
                        id: category.category,
                        title: category.category,
                        icon: iconForCategory(category.category),
                        eventCount: category.events.count
                    ))
                }
            }
        }
    }
    
    private func iconForCategory(_ name: String) -> String {
        switch name.lowercased() {
        case "workshop": return "hammer.fill"
        case "team building": return "person.3.fill"
        case "training": return "book.fill"
        case "conference": return "mic.fill"
        case "social": return "party.popper.fill"
        default: return "calendar"
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
            
            Text(message)
                .font(.system(size: 16))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
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
