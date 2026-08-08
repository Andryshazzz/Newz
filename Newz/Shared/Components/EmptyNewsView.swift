import SwiftUI

/// Empty news view with pure glass icon.
struct EmptyNewsView: View {
    /// Action to perform when retry button is tapped.
    let onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text("No News Available...")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 40)
            
            Button(action: onRetry) {
                Text("Try Again")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .frame(width: 80, height: 30)
            }
            .buttonStyle(.glass)
        }
        .frame(maxWidth: .infinity)
    }
}
