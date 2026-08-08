import SwiftUI

@main
struct NewzApp: App {
    /// Theme service.
    @StateObject
    private var themeService = ThemeService()
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environmentObject(themeService)
                .preferredColorScheme(themeService.colorScheme)
        }
    }
}
