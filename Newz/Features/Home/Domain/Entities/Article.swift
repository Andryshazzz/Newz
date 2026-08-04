import Foundation

/// An entity representing news articles.
struct Articles: Codable, Hashable {
    /// The status of the article.
    let status: String?
    
    /// Total number of articles available.
    let totalResults: Int?
    
    /// The articles.
    let articles: [Article]?
}

/// A entity representing a news article.
struct Article: Codable, Hashable, Identifiable {
    public var id: String { url ?? UUID().uuidString }
    
    /// The author of the article.
    let author: String?
    
    /// The headline or title of the article.
    let title: String
    
    /// A brief description or teaser of the article.
    let description: String?
    
    /// The direct URL to the full article.
    let url: String?
    
    /// The URL of the main image associated with the article.
    let urlToImage: String?
    
    /// The date and time when the article was published.
    let publishedAt: Date
    
    /// The full body content of the article.
    let content: String?
}
