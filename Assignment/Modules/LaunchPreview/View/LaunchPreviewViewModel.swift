import Foundation

struct LaunchPreviewViewModel {
    var launch: Launch
    
    var webViewRequest: URLRequest? {
        guard let article = launch.links.article, let url = URL(string: article) else { return nil }
        return URLRequest(url: url)
    }
}
