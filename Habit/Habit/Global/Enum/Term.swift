//
//  Term.swift
//  Habit
//
//  Created by hansol on 2021/11/29.
//

import Foundation

// MARK: - Term

enum Term: String, Codable {
    case DAILY = "DAILY"
    case HOURLY = "HOURLY"
    case WEEKLY = "WEEKLY"
    case MONTHLY = "MONTHLY"
    
    public var rawValue: String {
        switch self {
        case .DAILY: return "DAILY"
        case .HOURLY: return "HOURLY"
        case .WEEKLY: return "WEEKLY"
        case .MONTHLY: return "MONTHLY"
        }
    }
    
    public var stringValue: String {
        switch self {
        case .DAILY: return "일"
        case .HOURLY: return "시간"
        case .WEEKLY: return "주"
        case .MONTHLY: return "월"
        }
    }
}
