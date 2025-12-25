// MARK: - List Mode
struct ListModeView: View {
    @ObservedObject var viewModel: MyEventsViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("All My Events")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                ForEach(viewModel.allMyEvents) { event in
                    NavigationLink {
                        EventDetailsView(eventId: event.id)
                    } label: {
                        EventCardView(event: event)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical)
        }
        .background(Color(.systemGray6))
    }
}

// MARK: - Calendar Mode
struct CalendarModeView: View {
    @ObservedObject var viewModel: MyEventsViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // Upcoming Event
                if let upcomingEvent = viewModel.upcomingEvent {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Upcoming Event")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        NextEventCard(event: upcomingEvent)
                    }
                    
                    Divider()
                        .padding(.horizontal)
                }
                
                // Calendar
                CalendarPicker(selectedDate: $viewModel.selectedDate)
                    .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                // Events for Selected Date
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
                        ForEach(viewModel.eventsForSelectedDate) { event in
                            NavigationLink {
                                EventDetailsView(eventId: event.id)
                            } label: {
                                EventDetailCard(event: event)
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

// MARK: - Calendar Picker
struct CalendarPicker: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        DatePicker(
            "",
            selection: $selectedDate,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
    }
}
