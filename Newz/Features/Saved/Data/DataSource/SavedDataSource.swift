import Foundation
import SwiftData

/// Data source interface for saved articles.
protocol SavedDataSource {
    /// Fetches all saved articles.
    func fetchAll() throws -> [SavedArticle]
    
    /// Toggles save state for an article.
    func toggleSave(for article: Article) throws
    
    /// Deletes a saved article.
    func delete(_ article: SavedArticle) throws
    
    /// Checks if an article is saved.
    func isSaved(articleId: String) throws -> Bool
}

/// Implementation of SavedDataSource.
final class SavedDataSourceImpl: SavedDataSource {
    /// Data access object for saved articles.
    private let dao: SavedArticleDAO
    
    /// Creates a new instance of SavedDataSourceImpl.
    init(dao: SavedArticleDAO) {
        self.dao = dao
    }
    
    func fetchAll() throws -> [SavedArticle] {
        try dao.fetchAll()
    }
    
    func toggleSave(for article: Article) throws {
        try dao.save(article)
    }
    
    func delete(_ article: SavedArticle) throws {
        try dao.delete(article)
    }
    
    func isSaved(articleId: String) throws -> Bool {
        try dao.isSaved(articleId: articleId)
    }
}
