/// Interface for the global app dependency scope.
protocol MainAppScope {
    /// Theme service.
    var themeService: ThemeService { get }
    
    // Здесь можно добавить другие глобальные сервисы
}

/// Implementation of the global app dependency scope.
final class MainAppScopeImpl: MainAppScope {
    let themeService: ThemeService
    
    init() {
        self.themeService = ThemeService()
    }
}
