import Foundation

enum SortLaunchType {
    case successLaunches
    case `default`
}

protocol HomePresenter: AnyObject {
    func present()
    func set(sortedBy: SortLaunchType)
    func onPreviewTapped(with launch: Launch)
}

final class HomePresenterImp: HomePresenter {

    let interactor: HomeInteractor
    let router: HomeRouting
    let view: HomeView

    private var sortedBy: SortLaunchType = .default
    
    init(interactor: HomeInteractor, view: HomeView, router: HomeRouting) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
    
    func set(sortedBy: SortLaunchType) {
        self.sortedBy = sortedBy
        
        present()
    }
    
    func present() {
        view.startAnimating()
        
        interactor.getList { [weak self] launches, error in
            guard let self = self else { return }
            if let error = error {
                debugPrint(error.localizedDescription)
            } else if let launches = launches {
                var viewModels: [HomeViewModel]
                
                switch self.sortedBy {
                case .successLaunches:
                    viewModels = launches.filter { $0.success == true }.compactMap { HomeViewModel(launch: $0) }
                default:
                    viewModels = launches.compactMap { HomeViewModel(launch: $0) }
                }
                self.view.setViewModels(viewModels)
                self.view.stopAnimating()
            }
        }
    }
    
    func onPreviewTapped(with launch: Launch) {
        router.navigateTo(launch: launch)
    }
}
