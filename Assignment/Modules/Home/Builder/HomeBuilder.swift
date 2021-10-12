import UIKit

protocol HomeBuilder: AnyObject {
    func buildModule(navController: UINavigationController) -> UIViewController
}

final class HomeBuilderImp: HomeBuilder {
    func buildModule(navController: UINavigationController) -> UIViewController {
        let viewController = HomeViewController()
        let interactor = HomeInteractorImp(with: NetworkManagerImp())
        let router = HomeRouterImp()
        router.viewController = viewController
        let presenter = HomePresenterImp(interactor: interactor, view: viewController, router: router)
        viewController.presenter = presenter
        navController.pushViewController(viewController, animated: true)

        return navController
    }
}
