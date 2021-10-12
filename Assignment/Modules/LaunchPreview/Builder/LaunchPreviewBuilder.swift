import Foundation

protocol LaunchPreviewBuilder: AnyObject {
    func buildModule(with launchItem: Launch) -> LaunchPreviewViewController
}

final class LaunchPreviewBuilderImp: LaunchPreviewBuilder {
    func buildModule(with launchItem: Launch) -> LaunchPreviewViewController {
        let viewController = LaunchPreviewViewController()
        let interactor = LaunchPreviewInteractorImp(with: launchItem)
        
        let router = LaunchPreviewRouterImp()
        router.viewController = viewController
        
        let presenter = LaunchPreviewPresenterImp(interactor: interactor, view: viewController, router: router)
        viewController.presenter = presenter

        return viewController
    }
}
