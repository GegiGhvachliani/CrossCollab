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
                Picker("View Mode", selection: $viewModel.viewMode) {
                    ForEach(ViewMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Retry") {
                            viewModel.loadMyEvents()
                        }
                        .buttonStyle(.borderedProminent)
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
            if viewModel.registrations.isEmpty && !viewModel.isLoading {  // CHANGED
                viewModel.loadMyEvents()
            }
        }
    }
}
