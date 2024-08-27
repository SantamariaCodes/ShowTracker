import Moya
import Foundation

enum TvShowListTarget: Hashable, CaseIterable {
    static var allCases: [TvShowListTarget] {
         return [.popular,.topRated,  .onTheAir ]
     }
    
    case popular
    case airingToday
    case onTheAir
    case topRated
    case details(tvShowId: Int)
    case retrieveSubGenreList
    
//Custom add to simplify DashboardRow call
    var title: String {
        switch self {
        case .popular:
            return "Popular"
        case .airingToday:
            return "Airing Today"
        case .onTheAir:
            return "On The Air"
        case .topRated:
            return "Top Rated"
        case .details:
            return "Details"
        case .retrieveSubGenreList:
            return "list"
        }
    
    }
}

extension TvShowListTarget: TargetType {
    var baseURL: URL {
        return URL(string: Constants.API.baseUrl) ?? URL(string: "https://fallback.url")!
    }
    private var pathComponent: String {
           switch self {
           case .popular: return "popular"
           case .airingToday: return "airing_today"
           case .onTheAir: return "on_the_air"
           case .topRated: return "top_rated"
           case .details(let tvShowId): return "\(tvShowId)"
           case .retrieveSubGenreList: return "genre/tv/list"
           }
       }

    var path: String {
            switch self {
            case .retrieveSubGenreList: return pathComponent
            case .details: return "tv/\(pathComponent)"
            default: return "tv/\(pathComponent)"
            }
        }
    
    var method: Moya.Method { return .get }
    
    var task: Task {
        return .requestParameters(parameters: ["api_key": "\(Constants.API.apiKey)"], encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data { return Data() }
}
