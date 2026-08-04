import SwiftUI

/// Loading view with pure glass style.
struct LoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.2)
                .padding(.top, 60)
                .tint(
                    LinearGradient(
                        colors: [.black.opacity(0.9), .black.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
            
            Text("Loading news...")
                .font(.subheadline)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
    }
}
