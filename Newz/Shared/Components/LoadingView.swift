import SwiftUI

/// Loading view with pure glass style.
struct LoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.2)
                .padding(.top, 60)
                .tint(.secondary)
            
            Text("Loading news...")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}
