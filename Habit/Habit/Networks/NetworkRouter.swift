//
//  UserRouter.swift
//  Finut
//
//  Created by hansol on 2021/11/09.
//

import Foundation
import UIKit

import Moya

// MARK: - NetworkRouter

enum NetworkRouter {
    case login(param: LoginRequestModel)
    case signup(param: LoginRequestModel)
    case createQuest(param: QuestRequestModel)
    case fetchQuest
    case fetchQuestWithID(questID: String)
    case completeQuest(questID: String)
}

extension NetworkRouter: TargetType {
    public var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
    
    var path: String {
        switch self {
      
        case .login(param: _):
            return "auth/login"
        case .signup(param: _):
            return "user/register"
        case .createQuest(param: _):
            return "quest"
        case .fetchQuest:
            return "quest"
        case .fetchQuestWithID(questID: let questID):
            return "quest/\(questID)"
        case .completeQuest(questID: let questID):
            return "quest/\(questID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
    
        case .login(param: _):
            return .post
        case .signup(param: _):
            return .post
        case .createQuest(param: _):
            return .post
        case .fetchQuest:
            return .get
        case .fetchQuestWithID(questID: _):
            return .get
        case .completeQuest(questID: _):
            return .put
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            
        case .login(param: let param):
            return .requestParameters(parameters: try! param.asParameter(), encoding: JSONEncoding.default)
        case .signup(param: let param):
            return .requestParameters(parameters: try! param.asParameter(), encoding: JSONEncoding.default)
        case .createQuest(param: let param):
            return .requestParameters(parameters: try! param.asParameter(), encoding: JSONEncoding.default)
        case .fetchQuest:
            return .requestPlain
        case .fetchQuestWithID(questID: _):
            return .requestPlain
        case .completeQuest(questID: _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signup, .login:
            return ["Content-Type": "application/json"]
        default:
            if let accessToken = UserDefaultHandler.accessToken {
                return [
                    "Content-Type": "application/json",
                    "Authorization": accessToken
                ]
            }
            else { return [:] }
        }
    }
}
