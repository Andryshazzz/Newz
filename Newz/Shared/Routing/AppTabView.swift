import SwiftUI

/// Root view that manages tab-based navigation for the application.
struct AppTabView: View {
    /// Currently selected tab in the TabView
    @State private var selectedTab: AppTab = .news
    
    var body: some View {
            TabView(selection: $selectedTab) {
                NavigationStack {
                    HomeEntryView()
                }
                .tabItem {
                    Label(AppTab.news.label, systemImage: AppTab.news.icon)
                }
                .tag(AppTab.news)
                
                NavigationStack {
                    SavedEntryView()
                }
                .tabItem {
                    Label(AppTab.saved.label, systemImage: AppTab.saved.icon)
                }
                .tag(AppTab.saved)
                
                NavigationStack {
                    ProfileEntryView()
                }
                .tabItem {
                    Label(AppTab.profile.label, systemImage: AppTab.profile.icon)
                }
                .tag(AppTab.profile)
            }
            .environment(\.selectedAppTab, $selectedTab)
        }
}

/// Represents the available tabs in the application's tab bar.
enum AppTab: Int, CaseIterable {
    case news = 0
    case saved = 1
    case profile = 2
    
    /// Icon name for the tab
    var icon: String {
        switch self {
        case .news: return "newspaper.fill"
        case .saved: return "bookmark.fill"
        case .profile: return "person.circle.fill"
        }
    }
    
    /// Localized label text for the tab
    var label: String {
        switch self {
        case .news: return "News"
        case .saved: return "Saved"
        case .profile: return "Profile"
        }
    }
}

/// Environment key for injecting tab selection binding into the view hierarchy.
/// Allows child views to programmatically switch between tabs.
struct SelectedAppTabKey: EnvironmentKey {
    /// Default tab selection if no binding is provided via environment
    static let defaultValue: Binding<AppTab> = .constant(.news)
}

/// EnvironmentValues extension
extension EnvironmentValues {
    /// Binding to the currently selected tab in AppTabView.
    var selectedAppTab: Binding<AppTab> {
        get { self[SelectedAppTabKey.self] }
        set { self[SelectedAppTabKey.self] = newValue }
    }
}
