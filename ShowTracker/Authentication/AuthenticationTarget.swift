//
//  AuthenticationTarget.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/9/24.
//

import Moya
import Foundation

enum AuthenticationTarget {
    case requestToken
    case createSession(requestToken: String)
}

extension AuthenticationTarget: TargetType {
    var baseURL: URL {
        return URL(string: Constants.API.baseUrl)!
    }

    var path: String {
        // so the base https://api.themoviedb.org/3/ plus this
        switch self {
        case .requestToken:
            return "authentication/token/new"
        case .createSession:
            return "authentication/session/new"
        }
    }

    var method: Moya.Method {
        switch self {
        case .requestToken:
            return .get
        case .createSession:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .requestToken:
            return .requestParameters(parameters: ["api_key": Constants.API.apiKey], encoding: URLEncoding.queryString)
        case .createSession(let requestToken):
            return .requestParameters(parameters: ["api_key": Constants.API.apiKey, "request_token": requestToken], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }

    var sampleData: Data { return Data() }
}
