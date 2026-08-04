import Foundation

/// Date formatting extension.
extension Date {
    func relativeFormatted() -> String {
        let formatter = RelativeDateTimeFormatter()
        
        formatter.unitsStyle = .abbreviated
        
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
