//
//  BrowseView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI

struct BrowseView: View {
    @StateObject var viewModel: BrowseViewModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                VStack(spacing: 0) {
                    BrowseHeader()
                    
                    SearchAndFilterBar(
                        searchText: $viewModel.searchText,
                        onFilterTap: { viewModel.showFilters = true }
                    )
                    
                    CategoryBar(
                        categories: viewModel.categories,
                        selectedCategory: $viewModel.selectedCategory
                    )
                    
                    Divider()
                }
                
                ZStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if let error = viewModel.errorMessage {
                        ErrorView(message: error) {
                            viewModel.loadEvents()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if viewModel.filteredEvents.isEmpty {
                        EmptySearchView()
                    } else {
                        BrowseEventsList(events: viewModel.filteredEvents)
                    }
                }
            }
            .sheet(isPresented: $viewModel.showFilters) {
                FiltersSheet(viewModel: viewModel)
            }
            .onAppear {
                viewModel.loadEvents()
            }
            .refreshable {
                await viewModel.refreshEvents()
            }
        }
    }
}

#Preview {
    BrowseView(viewModel: DIContainer.shared.makeBrowseViewModel())
}
