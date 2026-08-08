import SwiftUI

/// Home view.
struct HomeView: View {
    /// The dependency scope provided by the parent view.
    @Environment(\.scope) private var scope: AnyScope?
    
    /// Home view model.
    @StateObject private var vm: HomeViewModel
    
    init(scope: HomeScope) {
        _vm = StateObject(
            wrappedValue: HomeViewModel(
                homeRepository: scope.homeRepository
            )
        )
    }
    
    var body: some View {
        NewsListView()
            .environmentObject(vm)
            .task {
                if vm.news.isEmpty {
                    vm.selectCategory(vm.selectedCategory)
                }
            }
    }
}
