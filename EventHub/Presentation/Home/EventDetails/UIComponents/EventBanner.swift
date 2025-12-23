// MARK: - Event Banner
struct EventBanner: View {
    let imageURL: String?
    
    var body: some View {
        ZStack {
            if let imageURL, let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    placeholderImage
                }
            } else {
                placeholderImage
            }
        }
        .frame(height: 192)
        .clipped()
    }
    
    private var placeholderImage: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
    }
}
