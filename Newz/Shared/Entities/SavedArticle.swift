import Foundation
import SwiftData

/// A SwiftData model representing a saved news article.
@Model
final class SavedArticle {
    /// Unique identifier for the article.
    @Attribute(.unique) var id: String
    
    /// The author of the article.
    var author: String?
    
    /// The headline or title of the article.
    var title: String
    
    /// A brief description or teaser of the article.
    var articleDescription: String?
    
    /// The direct URL to the full article.
    var url: String?
    
    /// The URL of the main image associated with the article.
    var urlToImage: String?
    
    /// The date and time when the article was published.
    var publishedAt: Date
    
    /// The full body content of the article.
    var content: String?
    
    /// Date when the article was saved.
    var savedAt: Date
    
    /// Creates a new saved article from an Article model.
    init(from article: Article) {
        self.id = article.id
        self.author = article.author
        self.title = article.title
        self.articleDescription = article.description
        self.url = article.url
        self.urlToImage = article.urlToImage
        self.publishedAt = article.publishedAt
        self.content = article.content
        self.savedAt = Date()
    }
}
