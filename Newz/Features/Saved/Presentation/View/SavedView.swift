import SwiftUI

/// View for displaying saved articles.
struct SavedView: View {
    /// The dependency scope.
    @Environment(\.scope) private var scope: AnyScope?
    
    /// Saved view model.
    @StateObject private var vm: SavedViewModel
    
    /// Creates a new instance of NewsDetailView.
    init(scope: SavedScope) {
        _vm = StateObject(
            wrappedValue: SavedViewModel(
                savedRepository: scope.savedRepository
            )
        )
    }
    
    var body: some View {
        Group {
            if vm.savedArticles.isEmpty {
                EmptySavedView()
            } else {
                List {
                    ForEach(vm.savedArticles) { savedArticle in
                        NavigationLink {
                            if let url = savedArticle.url, let _ = URL(string: url) {
                                NewsDetailView(article: Article(
                                    author: savedArticle.author,
                                    title: savedArticle.title,
                                    description: savedArticle.articleDescription,
                                    url: savedArticle.url,
                                    urlToImage: savedArticle.urlToImage,
                                    publishedAt: savedArticle.publishedAt,
                                    content: savedArticle.content
                                ))
                            }
                        } label: {
                            SavedArticleRow(article: savedArticle)
                        }
                    }
                    .onDelete(perform: vm.deleteArticles)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Saved")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.fetchSavedArticles()
        }
    }
}
