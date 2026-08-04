import Foundation

/// Application environment configuration.
enum AppEnvironment {
    /// The base URL for the news API.
    static var baseURL: String {
        Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    }
    
    /// The API key for the news API.
    static var apiKey: String {
        Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    }
}
