import SwiftUI

/// Row view for a saved article.
struct SavedArticleRow: View {
    /// Saved article.
    let article: SavedArticle
    
    var body: some View {
        HStack(spacing: 12) {
            if let imageUrl = article.urlToImage,
               let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    case .failure, .empty:
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.gray.opacity(0.2))
                            .frame(width: 80, height: 80)
                            .overlay(
                                Image(systemName: "newspaper")
                                    .foregroundColor(.gray)
                            )
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)
                
                if let author = article.author {
                    Text(author)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text(article.publishedAt.relativeFormatted())
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
