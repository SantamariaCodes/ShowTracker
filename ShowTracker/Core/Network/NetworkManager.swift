import Moya
import Foundation
// Generic Network Manager
class NetworkManager<T: TargetType> {
    var provider: MoyaProvider<T>
    
    init(plugins: [PluginType] = [NetworkLoggerPlugin()]) {
        provider = MoyaProvider<T>(plugins: plugins)
    }
    
    func request<U: Decodable>(target: T, completion: @escaping (Result<U, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(U.self, from: response.data)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
