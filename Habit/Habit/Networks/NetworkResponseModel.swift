//
//  NetworkResponseModel.swift
//  Habit
//
//  Created by hansol on 2021/11/29.
//

import Foundation

// MARK: - QuestResponseModel

struct QuestResponseModel: Codable {
    let questResponses: [QuestModel]
}

// MARK: - QuestModel

struct QuestModel: Codable {
    let id: String
    let title: String
    let term: Term
    let cycle: Int
    let startTime: String
    let endTime: String
    let days: [Days]
    let deadline: Int
    let totalAlarmCount: Int
    let accomplishCount: Int
    let accomplishable: Bool
}

// MARK: - LoginResponseModel

struct LoginResponseModel: Codable {
    let accessToken: String
    let refreshToken: String
    let userId: Int
    let userEmail: String
}
