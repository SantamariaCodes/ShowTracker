//
//  SearchTarget.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 8/10/24.
//

import Foundation
import Moya

enum SearchShowTarget {
    case searchTvShow(showName: String)
}

extension SearchShowTarget: TargetType {
    
    var baseURL: URL {
        return URL(string: Constants.API.baseUrl) ?? URL(string: "https://fallback.url")!
    }
    
    var path: String {
        switch self {
        case .searchTvShow:
            return "search/tv"
        }
    }
    
    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .searchTvShow(let showName):
            return .requestParameters(parameters: ["api_key": Constants.API.apiKey, "query": showName], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Data()
    }
}
