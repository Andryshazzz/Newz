/// Available news categories.
enum NewsCategory: String, CaseIterable {
    case general = "general"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
    
    /// Localized title for the category.
    var title: String {
        rawValue.description
    }
}
