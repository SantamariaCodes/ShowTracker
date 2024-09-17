import Moya
import Foundation

enum TvShowListTarget: Hashable, CaseIterable {
    static var allCases: [TvShowListTarget] {
        return [.popular(page: 1), .topRated(page: 1), .onTheAir(page: 1)]
    }
    
    case popular(page: Int)
    case airingToday(page: Int)
    case onTheAir(page: Int)
    case topRated(page: Int)
    case details(tvShowId: Int)
    case retrieveSubGenreList
    
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
         switch self {
         case .popular(let page),
              .airingToday(let page),
              .onTheAir(let page),
              .topRated(let page):
             return .requestParameters(parameters: ["api_key": "\(Constants.API.apiKey)", "page": page], encoding: URLEncoding.queryString)
         case .details, .retrieveSubGenreList:
             return .requestParameters(parameters: ["api_key": "\(Constants.API.apiKey)"], encoding: URLEncoding.queryString)

         }
     }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data { return Data() }
}


extension TvShowListTarget {
    func withUpdatedPage(_ page: Int) -> TvShowListTarget {
        switch self {
        case .popular:
            return .popular(page: page)
        case .airingToday:
            return .airingToday(page: page)
        case .onTheAir:
            return .onTheAir(page: page)
        case .topRated:
            return .topRated(page: page)
        default:
            return self
        }
    }
}
