// MARK: - About Event Section
struct AboutEventSection: View {
    let description: String
    
    var body: some View {
        if !description.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Text("About this event")
                    .font(.system(size: 18, weight: .semibold))
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
        }
    }
}
