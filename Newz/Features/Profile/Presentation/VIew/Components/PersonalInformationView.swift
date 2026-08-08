import SwiftUI

/// Personal information view.
struct PersonalInformationView: View {
        var body: some View {
            VStack(spacing: 20) {
                HStack(spacing: 16) {
                    Circle()
                        .fill(.tertiary)
                        .frame(width: 72, height: 72)
                        .overlay {
                            Image(systemName: "person.fill")
                                .font(.system(size: 28))
                        }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Alex Johnson")
                            .font(.title3.bold())
                            .foregroundStyle(.primary)
                        
                        Text(verbatim: "alex@mail.com")
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.tertiary)
                }
                
                Divider()
                
                HStack {
                    StatView(
                        title: "Articles read",
                        value: "124",
                    )
                    
                    Divider()
                    
                    StatView(
                        title: "Saved",
                        value: "36",
                    )
                    
                    StatView(
                        title: "Read time",
                        value: "18h 45m",
                    )
                }
                .frame(height: 20)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(uiColor: .secondarySystemBackground))
            )
        }
    }

    /// Stat view.
    private struct StatView: View {
        /// Title.
        let title: String
        
        /// Value.
        let value: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
