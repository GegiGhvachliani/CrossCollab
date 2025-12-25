// MARK: - Browse Events List
struct BrowseEventsList: View {
    let events: [Event]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(events) { event in
                    NavigationLink {
                        EventDetailsView(eventId: event.id)
                    } label: {
                        BrowseEventCard(event: event)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
    }
}