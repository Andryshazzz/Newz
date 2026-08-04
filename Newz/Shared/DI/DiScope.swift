import SwiftUI

/// A type-erased container that holds any scope instance.
struct AnyScope {
    /// The stored scope instance.
    let wrapped: Any
    
    /// Creates a new scope container with type erasure.
    init<T>(_ scope: T) {
        self.wrapped = scope
    }
    
    /// Attempts to cast the stored scope to the expected type.
    func resolve<T>() -> T? {
        return wrapped as? T
    }
}

/// Environment key for storing the universal scope container.
struct ScopeEnvironmentKey: EnvironmentKey {
    static var defaultValue: AnyScope? { nil }
}

/// A view modifier that provides a dependency scope to its child views.
struct DiScopeModifier: ViewModifier {
    /// Scope.
    let scope: AnyScope
    
    /// Creates a DiScopeModifier.
    init<T>(_ scope: T) {
        self.scope = AnyScope(scope)
    }
    
    func body(content: Content) -> some View {
        content
            .environment(\.scope, scope)
    }
}

/// Extension to easily apply the DiScope modifier.
extension View {
    /// Wraps the view with a dependency scope.
    /// Usage: SomeView().diScope(SomeScopeImpl())
    func diScope<T>(_ scope: T) -> some View {
        modifier(DiScopeModifier(scope))
    }
}

/// Universal scope accessor.
/// Use resolve<T>() to get the specific scope type.
extension EnvironmentValues {
    var scope: AnyScope? {
        get { self[ScopeEnvironmentKey.self] }
        set { self[ScopeEnvironmentKey.self] = newValue }
    }
}
