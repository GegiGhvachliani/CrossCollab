//
//  MyEventsView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI
import MapKit

struct MyEventsView: View {
    @StateObject var viewModel: MyEventsViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Segmented Picker
                Picker("View Mode", selection: $viewModel.viewMode) {
                    ForEach(ViewMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                // Content based on view mode
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)  // NEW
                            .padding()  // NEW
                        Button("Retry") {
                            viewModel.loadMyEvents()
                        }
                        .buttonStyle(.borderedProminent)  // NEW
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.registrations.isEmpty {
                    EmptyMyEventsView()
                } else {
                    if viewModel.viewMode == .list {
                        ListModeView(viewModel: viewModel)
                    } else {
                        CalendarModeView(viewModel: viewModel)
                    }
                }
            }
            .navigationTitle("My Events")
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .refreshable {
                await viewModel.refreshMyEvents()
            }
        }
        .onAppear {
            // Only load if we don't have data yet
            if viewModel.registrations.isEmpty && !viewModel.isLoading {  // CHANGED
                viewModel.loadMyEvents()
            }
        }
    }
}
