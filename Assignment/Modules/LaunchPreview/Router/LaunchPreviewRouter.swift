import Foundation

protocol LaunchPreviewRouter: AnyObject {
}

final class LaunchPreviewRouterImp: LaunchPreviewRouter {
    weak var viewController: LaunchPreviewViewController!
}
