import SwiftUI

/// Settings row.
struct SettingsRow: View {
    /// Icon.
    let icon: String
    
    /// Title.
    let title: String
    
    /// Subtitle.
    var subtitle: String? = nil
    
    /// Trailing.
    var trailing: String? = nil
    
    /// Show trailing icon.
    var showTrailingIcon: Bool = false
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .frame(width: 24)
                .foregroundStyle(.primary)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .foregroundStyle(.primary)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            if let trailing {
                Text(trailing)
                    .foregroundStyle(.secondary)
            }
            
            if showTrailingIcon {
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(.vertical, 14)
    }
}
