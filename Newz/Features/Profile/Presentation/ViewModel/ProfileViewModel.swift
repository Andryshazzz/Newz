import Foundation
import Combine

/// ViewModel for the profile screen.
class ProfileViewModel: ObservableObject {
    /// Indicates whether dark mode is enabled.
    @Published var isDarkMode: Bool
    
    /// Indicates whether data saver mode is enabled.
    @Published var dataSaver: Bool = false
    
    /// Theme service for managing app appearance.
    private let themeService: ThemeService
    
    /// Storage for Combine subscriptions to keep them alive.
    private var cancellables = Set<AnyCancellable>()
    
    /// Creates a new instance of `ProfileViewModel`.
    init(themeService: ThemeService) {
        self.themeService = themeService
        self.isDarkMode = themeService.theme == .dark
        
        setupBindings()
    }
    
    /// Sets up reactive bindings.
    private func setupBindings() {
        $isDarkMode
            .dropFirst()
            .sink { [weak self] isDark in
                self?.themeService.setTheme(isDark ? .dark : .light)
            }
            .store(in: &cancellables)
    }
    
    /// Toggles dark mode on/off.
    func toggleDarkMode() {
        isDarkMode.toggle()
    }
    
    /// Toggles data saver mode on/off.
    func toggleDataSaver() {
        // TODO: Implement data saver logic
        dataSaver.toggle()
    }
    
    /// Performs sign out action.
    func signOut() {
        // TODO: Implement sign out logic
        print("Sign out tapped")
    }
}
