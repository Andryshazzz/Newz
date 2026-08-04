import SwiftUI

/// Empty news view with pure glass icon.
struct EmptyNewsView: View {
    /// Action to perform when retry button is tapped.
    let onRetry: () -> Void
    
    var body: some View {
            VStack(spacing: 16) {
                Text("No News Available...")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.horizontal, 40)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 1, y: 1)
                
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
