import Foundation

enum HTTPMethodType: String {
    case get

    var name: String {
        return rawValue.capitalized
    }
}

enum NetworkManagerResponse<T: Codable> {
    case success(data: [T])
    case failure(error: Error)
}

protocol NetworkManager {
    func request<T: Codable>(methodType: HTTPMethodType, url: String, completionHandler: @escaping (NetworkManagerResponse<T>) -> Void)
}

final class NetworkManagerImp: NetworkManager {
    lazy private var defaultSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type": "application/json; charset=UTF-8"]
        config.waitsForConnectivity = false
        
        return URLSession(configuration: config, delegate: nil, delegateQueue: nil)
    }()
    
    func request<T: Codable>(methodType: HTTPMethodType, url: String, completionHandler: @escaping (NetworkManagerResponse<T>) -> Void) {
        guard let urlPath = URL(string: url) else {
            completionHandler(.failure(error:  "Wrong url \(url) passed".toError))
            return
        }
        
        var urlRequest = URLRequest(url: urlPath)
        urlRequest.httpMethod = methodType.name
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            let task = self?.defaultSession.dataTask(with: urlRequest) { data, response, error in
                DispatchQueue.main.async {
                    guard error == nil else {
                        completionHandler(.failure(error: "General HTTP error: \(error!.localizedDescription)".toError))
                        return
                    }
                    
                    guard let urlResponse = response as? HTTPURLResponse, (200..<300).contains(urlResponse.statusCode) else {
                        completionHandler(.failure(error: "Wrong HTTP response".toError))
                        return
                    }
                    
                    guard let data = data else {
                        completionHandler(.failure(error: "Wrong HTTP response".toError))
                        return
                    }
                    
                    do {
                        let jsonData = try JSONDecoder.newJSONDecoder().decode([T].self, from: data)
                        completionHandler(.success(data: jsonData))
                    } catch (let error) {
                        completionHandler(.failure(error: "Json parse error: \(error.localizedDescription)".toError))
                    }
                }
            }
            task?.resume()
        }
    }
}
