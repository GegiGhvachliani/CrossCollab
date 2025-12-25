// MARK: - Browse Header
struct BrowseHeader: View {
    var body: some View {
        HStack {
            Text("Browse Events")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            Image(systemName: "calendar")
                .font(.title2)
        }
        .padding()
    }
}
