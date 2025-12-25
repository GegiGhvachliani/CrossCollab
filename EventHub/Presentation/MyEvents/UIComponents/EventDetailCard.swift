// MARK: - Event Detail Card
struct EventDetailCard: View {
    let event: Event
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack {
                Text(formatHour(event.startDateTime))
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(formatAMPM(event.startDateTime))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(width: 60)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(event.title)
                    .font(.headline)
                
                Text(event.eventTypeName)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                HStack(spacing: 6) {
                    Image(systemName: "mappin.and.ellipse")
                    Text(event.location)
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4)
        .padding(.horizontal)
    }
    
    private func formatHour(_ dateString: String) -> String {
        let components = dateString.split(separator: "T")
        guard components.count >= 2 else { return "TBA" }
        let timeComponent = components[1].split(separator: ":")
        guard let hour = Int(timeComponent[0]) else { return "TBA" }
        let displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour)
        return String(format: "%02d:00", displayHour)
    }
    
    private func formatAMPM(_ dateString: String) -> String {
        let components = dateString.split(separator: "T")
        guard components.count >= 2 else { return "" }
        let timeComponent = components[1].split(separator: ":")
        guard let hour = Int(timeComponent[0]) else { return "" }
        return hour >= 12 ? "PM" : "AM"
    }
}
