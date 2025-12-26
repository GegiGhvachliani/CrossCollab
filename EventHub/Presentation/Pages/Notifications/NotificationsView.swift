//
//  NotificationsView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 22.12.25.
//

import SwiftUI

struct NotificationsView: View {
    @ObservedObject var viewModel: NotificationsViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                Picker("", selection: $viewModel.selectedType) {
                    ForEach(NotificationType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.filteredNotifications.isEmpty {
                    EmptyNotificationsView()
                } else {
                    NotificationsList(viewModel: viewModel)
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if viewModel.notifications.isEmpty {
                    viewModel.loadNotifications()
                }
            }
            .refreshable {
                await viewModel.refreshNotifications()
            }
        }
    }
}



#Preview {
    NotificationsView(viewModel: DIContainer.shared.makeNotificationsViewModel())
}
