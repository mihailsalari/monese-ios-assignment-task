import Foundation

public extension NSObject {

    class var nameOfClass: String {
        NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
