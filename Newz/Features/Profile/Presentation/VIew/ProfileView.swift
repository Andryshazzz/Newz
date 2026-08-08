import SwiftUI

/// Profile view.
struct ProfileView: View {
    /// The dependency scope pr;ovided by the parent view.
    @Environment(\.scope) private var scope: AnyScope?
    
    /// Profile view model.
    @StateObject private var vm: ProfileViewModel
    
    init(scope: ProfileScope) {
        _vm = StateObject(
            wrappedValue: ProfileViewModel(
                themeService: scope.themeService
            )
        )
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                Text("Profile")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.primary)
                
                PersonalInformationView()
                
                PreferencesGroup(title: "Reading preferences") {
                    Toggle(isOn: $vm.isDarkMode)
                    {
                        SettingsRow(
                            icon: "moon",
                            title: "Dark mode"
                        )
                    }
                    
                    Divider()
                    
                    SettingsRow(
                        icon: "textformat.size",
                        title: "Text size",
                        trailing: "Medium",
                        showTrailingIcon: true
                    )
                    
                    Divider()
                    
                    Toggle(isOn: $vm.dataSaver) {
                        SettingsRow(
                            icon: "arrow.down.circle",
                            title: "Data saver",
                            subtitle: "Download smaller images"
                        )
                    }
                }
                
                PreferencesGroup {
                    SettingsRow(
                        icon: "arrow.down.circle",
                        title: "Download settings",
                        showTrailingIcon: true
                    )
                    
                    Divider()
                    
                    SettingsRow(
                        icon: "bell",
                        title: "Notifications",
                        showTrailingIcon: true
                    )
                    
                    Divider()
                    
                    SettingsRow(
                        icon: "info.circle",
                        title: "About",
                        showTrailingIcon: true
                    )
                    
                    Divider()
                    
                    SettingsRow(
                        icon: "questionmark.circle",
                        title: "Help & Feedback",
                        showTrailingIcon: true
                    )
                }
                
                Button(role: .destructive) {
                    vm.signOut()
                } label: {
                    HStack {
                        Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.red)
                    }
                    .padding(.vertical, 14)
                }
                .buttonStyle(.glass)
            }
            .padding()
        }
        .background(.background)
    }
}
