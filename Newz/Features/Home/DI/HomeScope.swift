/// Interface for the home feature dependency scope.
protocol HomeScope {
    /// News data source.
    var newsDataSource: NewsDataSource { get }
    
    /// Repository for working with the main screen.
    var homeRepository: HomeRepository { get }
}

/// Implementation of the home feature dependency scope.
final class HomeScopeImpl: HomeScope {
    let newsDataSource: NewsDataSource
    let homeRepository: HomeRepository
    
    /// Creates a new instance of the home feature dependency scope.
    init() {
        self.newsDataSource = NewsDataSourceImpl()
        self.homeRepository = HomeRepositoryImpl(newsDataSource: newsDataSource)
    }
}
