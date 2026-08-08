import SwiftUI

/// Entry point for the Saved feature.
struct SavedEntryView: View {
    /// App scope.
    @Environment(\.scope) private var scope: AnyScope?
    
    var body: some View {
        if let appScope: AppScope = scope?.resolve() {
            let savedScope = SavedScopeImpl(appScope: appScope)
            
            SavedView(scope: savedScope)
                .diScope(savedScope)
        }
    }
}
