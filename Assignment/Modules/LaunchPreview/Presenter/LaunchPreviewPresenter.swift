import Foundation

protocol LaunchPreviewPresenter: AnyObject {
    func present()
}

final class LaunchPreviewPresenterImp: LaunchPreviewPresenter {
    private let interactor: LaunchPreviewInteractor
    private let view: LaunchPreviewView
    private let router: LaunchPreviewRouter

    init(interactor: LaunchPreviewInteractor, view: LaunchPreviewView, router: LaunchPreviewRouter) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
    
    func present() {
        view.configure(with: LaunchPreviewViewModel(launch: interactor.launchItem))
    }
}
