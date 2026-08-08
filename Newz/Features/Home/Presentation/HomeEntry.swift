import SwiftUI

/// Entry point for the Home feature.
/// Creates and provides the dependency scope for all screens within this feature.
struct HomeEntryView: View {
    /// App scope.
    @Environment(\.scope) private var scope: AnyScope?
    
    var body: some View {
        if let appScope: AppScope = scope?.resolve() {
            let homeScope = HomeScopeImpl(appScope: appScope)
            
            HomeView(scope: homeScope)
                .diScope(homeScope)
        }
    }
}
