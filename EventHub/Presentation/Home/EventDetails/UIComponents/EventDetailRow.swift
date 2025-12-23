// MARK: - Event Detail Row
struct EventDetailRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text(text)
        }
        .font(.system(size: 12))
        .foregroundColor(.secondary)
    }
}
