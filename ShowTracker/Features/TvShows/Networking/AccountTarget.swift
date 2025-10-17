//
//  AccountTarget.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 9/10/25.
//

import Foundation
import Moya

enum AccountTarget {
    
    case modifyFavorite(request: ModifyFavoriteRequest, accountId: String, sessionId: String)
}

extension AccountTarget: TargetType {
    
    var baseURL: URL {
        return URL(string: Constants.API.baseUrl)! 
    }
    
    var path: String {
        switch self {
        case .modifyFavorite(_, let accountId, _):
            return "account/\(accountId)/favorite"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .modifyFavorite(let request, _, let sessionId):
            
            
            let body: [String: Any] = [
                "media_type": request.mediaType,
                "media_id": request.mediaId,
                "favorite": request.favorite
            ]
            
           
            let query: [String: Any] = [
                "api_key": Constants.API.apiKey,
                "session_id": sessionId
            ]
            
            return .requestCompositeParameters(
                bodyParameters: body,
                bodyEncoding: JSONEncoding.default,
                urlParameters: query
            )
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
