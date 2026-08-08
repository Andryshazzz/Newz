import Foundation
import Combine

/// ViewModel for saved articles screen.
@MainActor
final class SavedViewModel: ObservableObject {
    /// Array of saved articles.
    @Published var savedArticles: [SavedArticle] = []
    
    /// Indicates whether data is loading.
    @Published var isLoading = false
    
    /// Dictionary tracking saved state for articles by ID.
    @Published var savedStates: [String: Bool] = [:]
    
    /// Repository for saved articles.
    private let savedRepository: SavedRepository
    
    /// Creates a new instance of SavedViewModel.
    init(savedRepository: SavedRepository) {
        self.savedRepository = savedRepository
    }
    
    /// Fetches all saved articles.
    func fetchSavedArticles() {
        isLoading = true
        
        do {
            savedArticles = try savedRepository.fetchSavedArticles()
            
            savedStates.removeAll()
            
            for article in savedArticles {
                savedStates[article.id] = true
            }
        } catch {
            print("Error fetching saved articles: \(error)")
        }
        
        isLoading = false
    }
    
    /// Toggles save state for an article.
    func toggleSave(for article: Article) {
        Task { @MainActor in
            do {
                try savedRepository.toggleSave(for: article)
                
                fetchSavedArticles()
            } catch {
                print("Error toggling save: \(error)")
            }
        }
    }
    
    /// Deletes articles at specified offsets.
    func deleteArticles(at offsets: IndexSet) {
        Task { @MainActor in
            for index in offsets {
                do {
                    try savedRepository.delete(savedArticles[index])
                } catch {
                    print("Error deleting article: \(error)")
                }
            }
            fetchSavedArticles()
        }
    }
    
    /// Deletes a single saved article.
    func deleteSavedArticle(_ savedArticle: SavedArticle) {
        do {
            try savedRepository.delete(savedArticle)
            
            savedStates[savedArticle.id] = false
            
            fetchSavedArticles()
        } catch {
            print("Error deleting article: \(error)")
        }
    }
    
    /// Checks if an article is saved.
    func isArticleSaved(_ article: Article) -> Bool {
        do {
            return try savedRepository.isSaved(articleId: article.id)
        } catch {
            print("Error checking save status: \(error)")
            return false
        }
    }
}
