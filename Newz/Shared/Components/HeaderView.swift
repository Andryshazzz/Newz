import SwiftUI

/// Universal header view with customizable title.
struct HeaderView: View {
    /// The title text displayed in the header.
    let title: String
    
    /// Creates a new instance of HeaderView.
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.primary)
    }
}
