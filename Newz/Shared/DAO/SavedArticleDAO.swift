import Foundation
import SwiftData

/// Data access object for saved articles.
protocol SavedArticleDAO {
    /// Fetches all saved articles.
    func fetchAll() throws -> [SavedArticle]
    
    /// Checks if an article is saved.
    func isSaved(articleId: String) throws -> Bool
    
    /// Saves an article.
    func save(_ article: Article) throws
    
    /// Deletes a saved article.
    func delete(_ article: SavedArticle) throws
}

/// Implementation of SavedArticleDAO using SwiftData.
final class SavedArticleDAOImpl: SavedArticleDAO {
    /// Model context for SwiftData operations.
    private let modelContext: ModelContext
    
    /// Creates a new instance of SavedArticleDAOImpl.
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchAll() throws -> [SavedArticle] {
        let descriptor = FetchDescriptor<SavedArticle>(
            sortBy: [SortDescriptor(\.savedAt, order: .reverse)]
        )
        
        return try modelContext.fetch(descriptor)
    }
    
    func isSaved(articleId: String) throws -> Bool {
        let predicate = #Predicate<SavedArticle> { $0.id == articleId }
        let descriptor = FetchDescriptor<SavedArticle>(predicate: predicate)
        
        return try modelContext.fetch(descriptor).first != nil
    }
    
    func save(_ article: Article) throws {
        if try isSaved(articleId: article.id) {
            let predicate = #Predicate<SavedArticle> { $0.id == article.id }
            let descriptor = FetchDescriptor<SavedArticle>(predicate: predicate)
            
            if let existing = try modelContext.fetch(descriptor).first {
                modelContext.delete(existing)
                
                try modelContext.save()
            }
            
            return
        }
        
        let savedArticle = SavedArticle(from: article)
        
        modelContext.insert(savedArticle)
        
        try modelContext.save()
    }
    
    func delete(_ article: SavedArticle) throws {
        modelContext.delete(article)
        
        try modelContext.save()
    }
}
