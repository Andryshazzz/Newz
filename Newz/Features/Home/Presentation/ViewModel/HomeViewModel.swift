import Foundation
import Combine

/// ViewModel for the home screen.
class HomeViewModel: ObservableObject {
    /// The array of fetched news articles.
    @Published var news: [Article] = []
    
    /// Currently selected category.
    @Published var selectedCategory: NewsCategory = .general
    
    /// Available categories.
    let categories = NewsCategory.allCases
    
    /// Indicates whether the initial data loading is in progress.
    @Published var isLoading = false
    
    /// Indicates whether additional pages are being loaded (pagination).
    @Published var isLoadingMore = false
    
    /// Indicates if there are more pages to load.
    @Published var hasMorePages = true
    
    /// Dictionary tracking saved state for each article by ID.
    @Published var savedStates: [String: Bool] = [:]
    
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
    
    /// Fetches news by category.
    func getNewsByCategory(_ category: String) {
        currentPage = 1
        hasMorePages = true
        isLoading = true
        
        homeRepository.getNewsByCategory(category, page: currentPage, pageSize: pageSize)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                
                switch completion {
                case .failure(let error):
                    print("Error loading news by category: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] news in
                guard let self = self else { return }
                
                self.news = news
                self.hasMorePages = news.count >= self.pageSize
                self.currentPage += 1
                self.updateSavedStates()
            }
            .store(in: &cancellables)
    }
    
    /// Changes the selected category and loads news.
    func selectCategory(_ category: NewsCategory) {
        selectedCategory = category
        getNewsByCategory(category.rawValue)
    }
    
    /// Loads the next page of news articles.
    func loadMoreNews() {
        guard !isLoadingMore, hasMorePages, !isLoading else { return }
        
        isLoadingMore = true
        
        homeRepository.getNewsByCategory(selectedCategory.rawValue, page: currentPage, pageSize: pageSize)
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
                
                self.updateSavedStates()
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
    
    /// Toggles save state for an article.
    func toggleSaveArticle(_ article: Article) {
        do {
            try homeRepository.saveArticle(article)
            
            savedStates[article.id] = !(savedStates[article.id] ?? false)
        } catch {
            print("Error saving article: \(error)")
        }
    }
    
    /// Updates saved states for all loaded articles.
    private func updateSavedStates() {
        for article in news {
            if savedStates[article.id] == nil {
                savedStates[article.id] = isArticleSaved(article)
            }
        }
    }
    
    /// Checks if an article is saved.
    private func isArticleSaved(_ article: Article) -> Bool {
        do {
            return try homeRepository.isArticleSaved(article)
        } catch {
            print("Error checking save status: \(error)")
            return false
        }
    }
}
