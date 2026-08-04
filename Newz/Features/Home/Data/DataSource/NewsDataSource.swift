import Foundation
import Combine

/// Data source interface for working with news.
protocol NewsDataSource {
    /// Retrieves a list of news articles.
    func getNews(page: Int, pageSize: Int) -> AnyPublisher<[Article], Error>
}

/// Implementation of the data source for working with news.
final class NewsDataSourceImpl: NewsDataSource {
    func getNews(page: Int, pageSize: Int = 10) -> AnyPublisher<[Article], any Error> {
        let url = "\(AppEnvironment.baseURL)/top-headlines?country=us&page=\(page)&pageSize=\(pageSize)&apiKey=\(AppEnvironment.apiKey)"
        
        guard let url = URL(string: url) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in
                if let httpResponse = response as? HTTPURLResponse {
                    print("📡 Status Code: \(httpResponse.statusCode)")
                }
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("📄 Response: \(jsonString.prefix(500))...")
                }
                return data
            }
            .decode(type: Articles.self, decoder: decoder)
            .map { response in
                print("📊 Total Results from API: \(response.totalResults ?? 0)")
                print("📊 Articles in this page: \(response.articles?.count ?? 0)")
                
                let validArticles = response.articles?.filter { article in
                    article.title != nil && article.url != nil
                } ?? []
                
                print("✅ Valid articles after filtering: \(validArticles.count)")
                
                return validArticles
            }
            .eraseToAnyPublisher()
    }
}
