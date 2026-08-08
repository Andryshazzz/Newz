import Foundation
import SwiftData

/// Application-wide dependency scope.
protocol AppScope {
    /// Theme service for managing app appearance.
    var themeService: ThemeService { get }
    
    /// Data access object for saved articles.
    var savedArticleDAO: SavedArticleDAO { get }
}

/// Implementation of application-wide dependency scope.
final class AppScopeImpl: AppScope {
    let themeService: ThemeService
    let savedArticleDAO: SavedArticleDAO
    
    init(modelContext: ModelContext, themeService: ThemeService) {
        self.themeService = themeService
        self.savedArticleDAO = SavedArticleDAOImpl(modelContext: modelContext)
    }
}
