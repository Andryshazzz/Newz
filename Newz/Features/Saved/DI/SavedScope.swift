import Foundation

/// Interface for the saved feature dependency scope.
protocol SavedScope {
    /// Data access object for saved articles.
    var savedArticleDAO: SavedArticleDAO { get }
    
    /// News data source.
    var savedDataSource: SavedDataSourceImpl { get }
    
    /// Repository for saved articles.
    var savedRepository: SavedRepository { get }
}

/// Implementation of the saved feature dependency scope.
final class SavedScopeImpl: SavedScope {
    let savedArticleDAO: SavedArticleDAO
    let savedDataSource: SavedDataSourceImpl
    let savedRepository: SavedRepository
    
    /// Creates a new instance of SavedScopeImpl.
    init(appScope: AppScope) {
        self.savedArticleDAO = appScope.savedArticleDAO
        self.savedDataSource = SavedDataSourceImpl(dao: savedArticleDAO)
        self.savedRepository = SavedRepositoryImpl(dataSource: savedDataSource)
    }
}
