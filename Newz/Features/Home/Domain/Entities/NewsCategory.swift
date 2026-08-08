/// Available news categories.
enum NewsCategory: String, CaseIterable {
    case general = "general"
//    case business = "business"
//    case entertainment = "entertainment"
//    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
    
    var title: String {
        rawValue.description
    }
}
