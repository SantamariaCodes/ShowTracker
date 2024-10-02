//  UserAccountTarget.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

import Foundation
import Moya

enum UserAccountTarget {
    case getAccountDetails(sessionID: String)
    case markFavorite(accountID: String, sessionID: String, mediaID: Int, favorite: Bool)
}

extension UserAccountTarget: TargetType {
    var baseURL: URL {
        return URL(string: Constants.API.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .getAccountDetails:
            return "account"
            
        case .markFavorite(let accountID, _, _, _):
            return "account/\(accountID)/favorite"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAccountDetails:
            return .get
        case .markFavorite:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .getAccountDetails(let sessionID):
            return .requestParameters(parameters: ["session_id": sessionID, "api_key": Constants.API.apiKey], encoding: URLEncoding.queryString)
            
        case .markFavorite(_, let sessionID, let mediaID, let favorite):
            let parameters: [String: Any] = [
                "media_type": "tv",
                "media_id": mediaID,
                "favorite": favorite,
                "session_id": sessionID
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
