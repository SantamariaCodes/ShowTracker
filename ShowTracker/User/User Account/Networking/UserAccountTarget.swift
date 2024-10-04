//  UserAccountTarget.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//


import Foundation
import Moya

enum UserAccountTarget {
    case getAccountDetails(sessionID: String)
    case getFavorites(accountID: String, sessionID: String, page: Int)
}

extension UserAccountTarget: TargetType {
    var baseURL: URL {
        return URL(string: Constants.API.baseUrl)!
    }

    var path: String {
        switch self {
        case .getAccountDetails:
            return "account"
        case .getFavorites(let accountID, _, _):
            return "account/\(accountID)/favorite/tv"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getAccountDetails, .getFavorites:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getAccountDetails(let sessionID):
            return .requestParameters(parameters: ["session_id": sessionID, "api_key": Constants.API.apiKey], encoding: URLEncoding.queryString)
            
        case .getFavorites(_, let sessionID, let page):
            return .requestParameters(parameters: [
                "session_id": sessionID,
                "api_key": Constants.API.apiKey,
                "page": page,
                "language": "en-US"
            ], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Data()
    }
}
