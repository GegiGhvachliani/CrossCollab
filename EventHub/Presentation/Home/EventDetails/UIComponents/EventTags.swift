// MARK: - Event Tags
struct EventTags: View {
    let tags: [String]
    
    var body: some View {
        if !tags.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 12))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(.systemGray6))
                            .foregroundColor(.primary)
                            .clipShape(Capsule())
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}