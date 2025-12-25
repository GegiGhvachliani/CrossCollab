
// MARK: - Filters Sheet
struct FiltersSheet: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: BrowseViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Date Range") {
                    DatePicker("Start Date", selection: Binding(
                        get: { viewModel.startDate ?? Date() },
                        set: { viewModel.startDate = $0 }
                    ), displayedComponents: .date)
                    
                    DatePicker("End Date", selection: Binding(
                        get: { viewModel.endDate ?? Date() },
                        set: { viewModel.endDate = $0 }
                    ), displayedComponents: .date)
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Reset") {
                        viewModel.resetFilters()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        dismiss()
                    }
                }
            }
        }
    }
}