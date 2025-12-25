// MARK: - Notifications List
struct NotificationsList: View {
    @ObservedObject var viewModel: NotificationsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // New Notifications
                if !viewModel.newNotifications.isEmpty {
                    Text("New")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(viewModel.newNotifications) { notification in
                        NotificationCard(notification: notification)
                            .onTapGesture {
                                viewModel.selectedNotification = notification
                            }
                    }
                }
                
                // Earlier Notifications
                if !viewModel.earlierNotifications.isEmpty {
                    Text("Earlier")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.top, viewModel.newNotifications.isEmpty ? 0 : 8)
                    
                    ForEach(viewModel.earlierNotifications) { notification in
                        NotificationCard(notification: notification)
                            .onTapGesture {
                                viewModel.selectedNotification = notification
                            }
                    }
                }
            }
            .padding(.vertical)
        }
    }
}