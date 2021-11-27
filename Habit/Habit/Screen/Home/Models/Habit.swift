//
//  Habit.swift
//  Habit
//
//  Created by 노한솔 on 2021/09/28.
//

import Foundation

// MARK: - Habit

struct Habit {
    let title: String
    let strikes: Int
    let term: Strike
    let isPublic: Bool
    let isQuest: Bool
    let companies: Int
    let deadLine: Int
}

enum Strike {
    case DAILY
    case TWICE
    case THREE
    case FOUR
    case FIVE
    case SIX
    case WEEKLY
    case DOUBLEWEEKLY
    case TRIPLEWEEKLY
    case MONTHLY
    
    public var rawValue: String {
        switch self {
        case .DAILY:
            return "매일"
        case .TWICE:
            return "2일"
        case .THREE:
            return "3일"
        case .FOUR:
            return "4일"
        case .FIVE:
            return "5일"
        case .SIX:
            return "6일"
        case .WEEKLY:
            return "매주"
        case .DOUBLEWEEKLY:
            return "2주일"
        case .TRIPLEWEEKLY:
            return "3주일"
        case .MONTHLY:
            return "매달"
        }
    }
}
