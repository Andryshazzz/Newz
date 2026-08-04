import SwiftUI

/// Card for news.
struct NewsCard: View {
    /// Article.
    let article: Article
    
    /// The horizontal size class of the current environment.
    /// Used to adapt the layout for different device sizes.
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    /// Flag for save button state.
    @State private var isSaved: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if let imageUrl = article.urlToImage,
               let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        LoadingPlaceholder()
                    case .success(let image):
                        RoundedRectangle(cornerRadius: 16)
                            .overlay(image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 220)
                                .clipped())
                    case .failure:
                        FallbackPlaceholder()
                    default:
                        EmptyView()
                    }
                }
            } else {
                FallbackPlaceholder()
            }
            
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.0),
                    Color.black.opacity(0.1),
                    Color.black.opacity(0.6),
                    Color.black.opacity(0.8)
                ]),
                startPoint: .center,
                endPoint: .bottom
            )
            
            HStack(alignment: .bottom, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    GlowText(
                            text: article.title,
                            font: .headline,
                            fontWeight: .bold,
                            lineLimit: 2,
                        )
                    
                    HStack(spacing: 4) {
                        if let author = article.author {
                            GlowText(
                                text: author,
                                font: .caption,
                                fontWeight: .medium,
                                lineLimit: 1,
                                opacity: 0.9
                            )
                        }
                        
                        if article.author != nil {
                            Text("•")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        
                            GlowText(
                                text: article.publishedAt.relativeFormatted(),
                                font: .caption,
                                fontWeight: .medium,
                                lineLimit: 1,
                                opacity: 0.9
                            )
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Button{
                    isSaved.toggle()
                } label: {
                    Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(isSaved ? .blue : .primary)
                }
                .buttonStyle(.glass)
            }
            .padding(16)
        }
        .frame(height: 220)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.5), radius: 3, x: 1, y: 1)
    }
}

/// Fallback placeholder.
private struct FallbackPlaceholder: View {
    var body: some View {
        Color.clear
            .overlay(
                Image(systemName: "newspaper.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white.opacity(0.9), .white.opacity(0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        LinearGradient(
                            colors: [.white.opacity(0.4), .clear],
                            startPoint: .top,
                            endPoint: .center
                        )
                        .mask(
                            Image(systemName: "newspaper.fill")
                                .font(.system(size: 50))
                        )
                    )
            )
            .frame(height: 220)
            .background(
                ZStack {
                    Color.gray.opacity(0.15)
                    Color.white.opacity(0.05)
                        .blur(radius: 100)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

/// Loading placeholder
private struct LoadingPlaceholder: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.gray.opacity(0.2))
            .frame(height: 220)
            .overlay(
                ProgressView()
                    .tint(
                        LinearGradient(
                            colors: [.white.opacity(0.9), .white.opacity(0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: .white.opacity(0.1), radius: 10, x: 0, y: 0)
            )
    }
}
