//
//  NetworkRequestModel.swift
//  Habit
//
//  Created by hansol on 2021/11/29.
//

import Foundation

// MARK: - QuestRequestModel

struct QuestRequestModel: Codable {
    var title: String
    var term: Term
    var cycle: Int
    var startTime: String
    var endTime: String
    var days: [Days]
    var deadline: Int
    
    init() {
        title = ""
        term = .HOURLY
        cycle = 0
        startTime = "00:00"
        endTime = "00:00"
        days = []
        deadline = 0
    }
    
    init(model: QuestModel) {
        title = model.title
        term = model.term
        cycle = model.cycle
        startTime = model.startTime
        endTime = model.endTime
        days = model.days
        deadline = model.deadline
    }
}

// MARK: - LoginRequestModel

struct LoginRequestModel: Codable {
    var email: String
    var password: String
}
