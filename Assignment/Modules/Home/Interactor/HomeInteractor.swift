import Foundation

protocol HomeInteractor: AnyObject {
    func getList(ofLaunches completion: @escaping ([Launch]?, Error?) -> Void)
}

final class HomeInteractorImp: HomeInteractor {
    private let networkManager: NetworkManager
    
    init(with networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getList(ofLaunches completion: @escaping ([Launch]?, Error?) -> Void) {
        networkManager.request(methodType: .get, url: APIType.launches.rawValue) { (response: NetworkManagerResponse<Launch>) in
            switch response {
            case .success(let posts):
                completion(posts, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
