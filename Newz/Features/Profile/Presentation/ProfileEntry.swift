import SwiftUI

/// Entry point for the Profile feature.
/// Creates and provides the dependency scope for all screens within this feature.
struct ProfileEntryView: View {
    
    /// Theme service from app root.
    @EnvironmentObject private var themeService: ThemeService
    
    var body: some View {
        let scope = ProfileScopeImpl(themeService: themeService)
        
        ProfileView(scope: scope)
            .diScope(scope)
    }
}
