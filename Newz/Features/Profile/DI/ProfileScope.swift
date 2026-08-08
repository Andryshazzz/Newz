/// Interface for the profile feature dependency scope.
protocol ProfileScope {
    /// Theme service for managing app appearance.
    var themeService: ThemeService { get }
}

/// Implementation of the profile feature dependency scope.
final class ProfileScopeImpl: ProfileScope {
    let themeService: ThemeService
    
    /// Creates a new instance of the profile feature dependency scope.
    init(themeService: ThemeService) {
        self.themeService = themeService
    }
}
