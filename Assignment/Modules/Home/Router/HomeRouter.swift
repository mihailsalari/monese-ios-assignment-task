import UIKit

protocol HomeRouting: AnyObject {
    func navigateTo(launch: Launch)
}

final class HomeRouterImp: HomeRouting {
    weak var viewController: HomeViewController!
    
    func navigateTo(launch: Launch) {
        let controller = LaunchPreviewBuilderImp().buildModule(with: launch)
        viewController.navigationController?.pushViewController(controller, animated: true)
    }
}
