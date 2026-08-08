import Foundation
import Combine

/// Repository interface for working with the main screen.
protocol HomeRepository {
    /// Retrieves news by category.
    func getNewsByCategory(_ category: String, page: Int, pageSize: Int) -> AnyPublisher<[Article], Error>
}

/// Implementation of the repository for working with the main screen.
final class HomeRepositoryImpl: HomeRepository {
    /// News data source.
    private let newsDataSource: NewsDataSource
    
    /// Creates a new instance of `HomeRepositoryImpl`.
    init(newsDataSource: NewsDataSource) {
           self.newsDataSource = newsDataSource
       }
    
    func getNewsByCategory(_ category: String, page: Int, pageSize: Int) -> AnyPublisher<[Article], Error> {
           newsDataSource.getNewsByCategory(category, page: page, pageSize: pageSize)
       }
}
