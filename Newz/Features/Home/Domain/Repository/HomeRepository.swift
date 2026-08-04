import Foundation
import Combine

/// Repository interface for working with the main screen.
protocol HomeRepository {
    /// Retrieves a list of news articles.
    func getNews(page: Int, pageSize: Int) -> AnyPublisher<[Article], Error>
}

/// Implementation of the repository for working with the main screen.
final class HomeRepositoryImpl: HomeRepository {
    /// News data source.
    private let newsDataSource: NewsDataSource
    
    /// Creates a new instance of `HomeRepositoryImpl`.
    init(newsDataSource: NewsDataSource) {
           self.newsDataSource = newsDataSource
       }
    
    func getNews(page: Int, pageSize: Int = 10) -> AnyPublisher<[Article], any Error> {
        return newsDataSource.getNews(page: page, pageSize: pageSize)
    }
}
