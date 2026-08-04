import Foundation
import Combine

/// ViewModel for the home screen.
class HomeViewModel: ObservableObject {
    /// The array of fetched news articles.
    @Published var news: [Article] = []
    
    /// Indicates whether the initial data loading is in progress.
    @Published var isLoading = false

    /// Indicates whether additional pages are being loaded (pagination).
    @Published var isLoadingMore = false
        
    /// Indicates if there are more pages to load.
    @Published var hasMorePages = true
        
    /// Current page number for pagination.
    private var currentPage = 1
        
    /// Number of articles per page.
    private let pageSize = 10
    
    /// Repository for working with the main screen.
    private let homeRepository: HomeRepository
    
    /// Storage for Combine subscriptions to keep them alive.
    private var cancellables = Set<AnyCancellable>()
    
    /// Creates a new instance of `HomeViewModel`.
    init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
    }
    
    /// Fetches news articles from the repository.
    func getNews() {
           currentPage = 1
           hasMorePages = true
           isLoading = true
        
           homeRepository.getNews(page: currentPage, pageSize: pageSize)
               .receive(on: DispatchQueue.main)
               .sink { [weak self] completion in
                   self?.isLoading = false
                   
                   switch completion {
                   case .failure(let error):
                       print("Error loading news: \(error)")
                   case .finished:
                       break
                   }
               } receiveValue: { [weak self] news in
                   guard let self = self else { return }
                   
                   self.news = news
                   self.hasMorePages = news.count >= self.pageSize
                   self.currentPage += 1
               }
               .store(in: &cancellables)
       }
       
       /// Loads the next page of news articles.
       func loadMoreNews() {
           guard !isLoadingMore, hasMorePages, !isLoading else { return }
           
           isLoadingMore = true
           
           homeRepository.getNews(page: currentPage, pageSize: pageSize)
               .receive(on: DispatchQueue.main)
               .sink { [weak self] completion in
                   self?.isLoadingMore = false
                   
                   switch completion {
                   case .failure(let error):
                       print("Error loading more news: \(error)")
                   case .finished:
                       break
                   }
               } receiveValue: { [weak self] newArticles in
                   guard let self = self else { return }
                   
                   self.news.append(contentsOf: newArticles)
                   self.hasMorePages = newArticles.count >= self.pageSize
                   self.currentPage += 1
               }
               .store(in: &cancellables)
       }
       
       /// Checks if we need to load more news based on the current index.
       func loadMoreNewsIfNeeded(currentIndex: Int) {
           let threshold = news.count - 3
           
           if currentIndex >= threshold {
               loadMoreNews()
           }
       }
}
