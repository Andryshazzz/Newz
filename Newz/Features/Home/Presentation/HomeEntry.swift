import SwiftUI

/// Entry point for the Home feature.
/// Creates and provides the dependency scope for all screens within this feature.
struct HomeEntryView: View {
    
    /// Home scope.
    private let scope = HomeScopeImpl()

    var body: some View {
        HomeView(scope: scope)
            .diScope(scope)
    }
}
