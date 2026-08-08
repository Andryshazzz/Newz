import SwiftUI
import SwiftData

@main
struct NewzApp: App {
    var body: some Scene {
        WindowGroup {
            AppEntryView()
        }
        .modelContainer(for: SavedArticle.self)
    }
}

/// Entry view that sets up app scope with model context.
struct AppEntryView: View {
    /// The model context provided by SwiftData for database operations.
    @Environment(\.modelContext) private var modelContext
    
    /// Theme service observed for reactive color scheme updates.
    @StateObject private var themeService: ThemeService
    
    /// Application scope.
    @State private var appScope: AppScope?
    
    init() {
        let service = ThemeService()
        
        _themeService = StateObject(wrappedValue: service)
    }
    
    var body: some View {
        Group {
            if let scope = appScope {
                AppTabView()
                    .environmentObject(scope.themeService)
                    .preferredColorScheme(scope.themeService.colorScheme)
                    .diScope(scope)
            }
        }
        .onAppear {
            appScope = AppScopeImpl(
                modelContext: modelContext,
                themeService: themeService
            )
        }
    }
}
