import SwiftUI
import Combine

/// A service responsible for managing the application's appearance.
///
/// `ThemeService` stores the user's selected theme, persists it between launches,
/// and provides the current `ColorScheme` used by the root view.
final class ThemeService: ObservableObject {

    /// Available application themes.
    enum Theme: String {

        /// Forces the application to use the light appearance.
        case light

        /// Forces the application to use the dark appearance.
        case dark
    }

    /// The key used to persist the selected theme in `UserDefaults`.
    private let storageKey = "appTheme"

    /// The currently selected application theme.
    ///
    /// Updating this property causes SwiftUI views observing the service
    /// to refresh automatically.
    @Published var theme: Theme

    /// Creates a new theme service.
    ///
    /// The previously selected theme is restored from `UserDefaults`.
    /// If no value exists, the light theme is used.
    init() {
        let rawValue = UserDefaults.standard.string(forKey: storageKey)

        theme = Theme(rawValue: rawValue ?? "") ?? .light
    }

    /// The `ColorScheme` corresponding to the current theme.
    ///
    /// This value should be passed to `.preferredColorScheme(_)`
    /// on the application's root view.
    var colorScheme: ColorScheme {
        theme == .dark ? .dark : .light
    }

    /// Applies the specified theme.
    ///
    /// The change is animated using a cross-dissolve transition on the application's
    /// main window to provide a smoother visual transition than the default SwiftUI behavior.
    ///
    /// The selected theme is also persisted in `UserDefaults`.
    ///
    /// - Parameter theme: The theme to apply.
    func setTheme(_ theme: Theme) {

        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else {

            self.theme = theme

            UserDefaults.standard.set(theme.rawValue, forKey: storageKey)

            return
        }

        UIView.transition(
            with: window,
            duration: 0.35,
            options: .transitionCrossDissolve
        ) {
            self.theme = theme

            UserDefaults.standard.set(theme.rawValue, forKey: self.storageKey)
        }
    }

    /// Toggles between the light and dark themes.
    func toggle() {
        setTheme(theme == .light ? .dark : .light)
    }

    /// Indicates whether the dark theme is currently active.
    var isDark: Bool {
        theme == .dark
    }
}
