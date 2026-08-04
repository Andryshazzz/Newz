import SwiftUI

/// Text with glow effect.
struct GlowText: View {
    let text: String
    let font: Font
    let fontWeight: Font.Weight
    var lineLimit: Int? = nil
    var opacity: Double = 1.0
    
    var body: some View {
           Text(text)
               .font(font)
               .fontWeight(fontWeight)
               .foregroundStyle(
                   LinearGradient(
                       colors: [
                           .white.opacity(1 * opacity),
                           .white.opacity(0.8 * opacity)
                       ],
                       startPoint: .leading,
                       endPoint: .bottomTrailing
                   )
               )
               .shadow(color: .blue.opacity(0.2 * opacity), radius: 15, x: 0, y: 0)
               .shadow(color: .white.opacity(0.4 * opacity), radius: 8, x: 0, y: 0)
               .lineLimit(lineLimit)
               .multilineTextAlignment(.leading)
       }
}
