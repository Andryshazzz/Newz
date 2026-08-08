import SwiftUI

/// View shown when no articles are saved.
struct EmptySavedView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "bookmark.slash")
                .font(.system(size: 50))
                .foregroundStyle(.secondary)
            
            Text("No Saved Articles")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Articles you save will appear here")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}
