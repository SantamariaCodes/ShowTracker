//
//  AccountTarget.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 9/10/25.
//


import Foundation
import Moya

enum AccountTarget {
    case modifyFavorite(request: ModifyFavoriteRequest, accountId: String)
}

extension AccountTarget: TargetType {
    var baseURL: URL {
        return URL(string: Constants.API.baseUrl) ?? URL(string: "https://fallback.url")!
    }
    
    var path: String {
        switch self {
        case .modifyFavorite(_, let sessionId):
            return "account/\(sessionId)/favorite"
        }
    }
    
    var method: Moya.Method {
        return .post
    }

    var task: Task {
        switch self {
        case .modifyFavorite(let request, _):
            let parameters: [String: Any] = [
                "media_type": request.mediaType,
                "media_id": request.mediaId,
                "favorite": request.favorite
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
