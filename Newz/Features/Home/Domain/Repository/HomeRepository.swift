import Foundation
import Combine

/// Repository for working with the main screen.
protocol HomeRepository {
    /// Retrieves news by category.
    func getNewsByCategory(_ category: String, page: Int, pageSize: Int) -> AnyPublisher<[Article], Error>
    
    /// Saves an article locally.
    func saveArticle(_ article: Article) throws
    
    /// Checks if an article is saved.
    func isArticleSaved(_ article: Article) throws -> Bool
}

/// Implementation of the home repository.
final class HomeRepositoryImpl: HomeRepository {
    private let newsDataSource: NewsDataSource
    
    init(newsDataSource: NewsDataSource) {
        self.newsDataSource = newsDataSource
    }
    
    func getNewsByCategory(_ category: String, page: Int, pageSize: Int) -> AnyPublisher<[Article], Error> {
        newsDataSource.getNewsByCategory(category, page: page, pageSize: pageSize)
    }
    
    func saveArticle(_ article: Article) throws {
        try newsDataSource.saveArticle(article)
    }
    
    func isArticleSaved(_ article: Article) throws -> Bool {
        try newsDataSource.isArticleSaved(article)
    }
}
