import SwiftUI

/// News detail view.
struct NewsDetailView: View {
    /// Article.
    let article: Article
    
    /// Flag for save button state.
    let isSaved: Bool
    
    /// Flag for show save button.
    let showSaveButton: Bool
    
    /// Action closure triggered when the save button is tapped.
    var onSave: (() -> Void)?
    
    /// Random article reading time.
    private let randomReadTime: Int
       
    /// Creates a new instance of NewsDetailView.
    init(article: Article, isSaved: Bool = false, showSaveButton: Bool = false, onSave: (() -> Void)? = nil) {
        self.article = article
        self.isSaved = isSaved
        self.showSaveButton = showSaveButton
        self.onSave = onSave
        self.randomReadTime = Int.random(in: 1...15)
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { screenGeometry in
                ZStack(alignment: .topLeading) {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 12) {
                            
                            HStack {
                                Text(article.publishedAt.relativeFormatted())
                                    .foregroundStyle(.secondary)
                                    .font(.system(size: 13, weight: .medium))
                                
                                Text("·")
                                    .foregroundStyle(.secondary)
                                
                                Text("\(randomReadTime) min read")
                                    .foregroundStyle(.secondary)
                                    .font(.system(size: 12, weight: .medium))
                            }
                            
                            Text(article.title)
                                .foregroundStyle(.primary)
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                            
                            if let urlToImage = article.urlToImage,
                               let url = URL(string: urlToImage) {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        EmptyView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                    case .failure:
                                        EmptyView()
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                            }
                            
                            if let description = article.description {
                                Text(description)
                                    .foregroundStyle(.primary)
                                    .font(.system(size: 16, weight: .regular))
                            }
                            
                            Text("Authors:")
                                .foregroundStyle(.secondary)
                                .font(.system(size: 13, weight: .medium))
                                .padding(.top, 12)
                            
                            if let author = article.author, !author.isEmpty {
                                Text(author)
                                    .foregroundStyle(.secondary)
                                    .font(.system(size: 13, weight: .medium))
                            }
                        }
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if showSaveButton {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            onSave?()
                        } label: {
                            Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                                .foregroundStyle(isSaved ? .blue : .primary)
                        }
                    }
                }
            }
        }
    }
}
