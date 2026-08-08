import SwiftUI

/// Horizontal category picker with liquid glass effect.
struct CategoryTabBar: View {
    /// Available categories.
    let categories: [NewsCategory]
    
    /// Currently selected category.
    @Binding var selectedCategory: NewsCategory
    
    /// Action when category is selected.
    var onCategorySelected: ((NewsCategory) -> Void)?
    
    var body: some View {
        Picker("Category", selection: $selectedCategory) {
            ForEach(categories, id: \.self) { category in
                Text(category.title)
                    .tag(category)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 16)
        .onChange(of: selectedCategory) { oldValue, newValue in
            onCategorySelected?(newValue)
        }
    }
}
