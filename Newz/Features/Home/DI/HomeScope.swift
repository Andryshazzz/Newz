/// Interface for the home feature dependency scope.
protocol HomeScope {
    /// Data access object for saved articles.
    var savedArticleDAO: SavedArticleDAO { get }
    
    /// News data source.
    var newsDataSource: NewsDataSource { get }
    
    /// Repository for working with the main screen.
    var homeRepository: HomeRepository { get }

}

/// Implementation of the home feature dependency scope.
final class HomeScopeImpl: HomeScope {
    let savedArticleDAO: SavedArticleDAO
    let newsDataSource: NewsDataSource
    let homeRepository: HomeRepository
    
    /// Creates a new instance of the home feature dependency scope.
    init(appScope: AppScope) {
        self.savedArticleDAO = appScope.savedArticleDAO
        self.newsDataSource = NewsDataSourceImpl(savedArticleDAO: savedArticleDAO)
        self.homeRepository = HomeRepositoryImpl(newsDataSource: newsDataSource)
    }
}
