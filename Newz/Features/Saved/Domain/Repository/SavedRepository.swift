import Foundation

/// Repository for working with saved articles.
protocol SavedRepository {
    /// Fetches all saved articles.
    func fetchSavedArticles() throws -> [SavedArticle]
    
    /// Toggles save state for an article.
    func toggleSave(for article: Article) throws
    
    /// Deletes a saved article.
    func delete(_ article: SavedArticle) throws
    
    /// Checks if an article is saved.
    func isSaved(articleId: String) throws -> Bool
}

/// Implementation of SavedRepository.
final class SavedRepositoryImpl: SavedRepository {
    /// Data source for saved articles.
    private let dataSource: SavedDataSource
    
    /// Creates a new instance of SavedRepositoryImpl.
    init(dataSource: SavedDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchSavedArticles() throws -> [SavedArticle] {
        try dataSource.fetchAll()
    }
    
    func toggleSave(for article: Article) throws {
        try dataSource.toggleSave(for: article)
    }
    
    func delete(_ article: SavedArticle) throws {
        try dataSource.delete(article)
    }
    
    func isSaved(articleId: String) throws -> Bool {
        try dataSource.isSaved(articleId: articleId)
    }
}
