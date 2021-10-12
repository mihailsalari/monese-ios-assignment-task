import Foundation

protocol LaunchPreviewInteractor: AnyObject {
    var launchItem: Launch { get }
}

final class LaunchPreviewInteractorImp: LaunchPreviewInteractor {
    var launchItem: Launch

    init(with launchItem: Launch) {
        self.launchItem = launchItem
    }
}
