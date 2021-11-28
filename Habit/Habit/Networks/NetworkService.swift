//
//  NetworkService.swift
//  Habit
//
//  Created by hansol on 2021/11/29.
//

import Foundation

import Moya
import RxSwift

// MARK: - NetworkService

class NetworkService {
    private let provider : MoyaProvider<NetworkRouter>
    init(provider : MoyaProvider<NetworkRouter>) {
        self.provider = provider
    }
}

extension NetworkService {
    
    func login(param: LoginRequestModel) -> Observable<Response> {
        provider.rx.request(.login(param: param))
            .asObservable()
    }
    
    func signup(param: LoginRequestModel) -> Observable<Response> {
        provider.rx.request(.signup(param: param))
            .asObservable()
    }
    
    func createQuest(param: QuestRequestModel) -> Observable<Response> {
        provider.rx.request(.createQuest(param: param))
            .asObservable()
    }
    
    func fetchQuest() -> Observable<Response> {
        provider.rx.request(.fetchQuest)
            .asObservable()
    }
    
    func fetchQuestWithID(questID: String) -> Observable<Response> {
        provider.rx.request(.fetchQuestWithID(questID: questID))
            .asObservable()
    }
    
    func completeQuest(questID: String) -> Observable<Response> {
        provider.rx.request(.completeQuest(questID: questID))
            .asObservable()
    }
}



