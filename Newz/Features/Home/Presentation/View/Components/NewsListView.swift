import SwiftUI

/// Main news list view.
struct NewsListView: View {
    /// Home view model obtained from the environment.
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        NavigationView{
            VStack {
                HeaderView()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.all, 16)
                
                
                CategoryTabBar(
                    categories: vm.categories,
                    selectedCategory: $vm.selectedCategory,
                    onCategorySelected: { category in
                        vm.selectCategory(category)
                    }
                )
                .padding(.bottom, 12)
                
                ScrollView {
                    if !vm.isLoading && !vm.news.isEmpty {
                        LazyVStack(spacing: 16) {
                            ForEach(Array(vm.news.enumerated()), id: \.element.url) { index, article in
                                NavigationLink(destination: NewsDetailView(article: article)) {
                                    NewsCard(article: article)
                                        .onAppear {
                                            vm.loadMoreNewsIfNeeded(currentIndex: index)
                                        }
                                }
                            }
                            
                            if vm.isLoadingMore {
                                LoadingView()
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        .padding(.bottom, 20)
                    }
                }
            }
            .overlay {
                if vm.isLoading {
                    LoadingView()
                } else if vm.news.isEmpty {
                    EmptyNewsView(
                        onRetry: {
                            vm.selectCategory(vm.selectedCategory)
                        }
                    )
                }
            }
        }
    }
}
