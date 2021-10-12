import Foundation

extension String {
    var toError: NSError {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: self])
    }
}
