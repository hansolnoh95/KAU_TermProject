//
//  File.swift
//  Habit
//
//  Created by hansol on 2021/11/29.
//

import Foundation

// MARK: - Days

enum Days: String, Codable {
    case MONDAY = "MONDAY"
    case TUESDAY = "TUESDAY"
    case WEDNESDAY = "WEDNESDAY"
    case THURSDAY = "THURSDAY"
    case FRIDAY = "FRIDAY"
    case SATURDAY = "SATURDAY"
    case SUNDAY = "SUNDAY"
    
    public var rawValue: String {
        switch self {
        case .MONDAY:
            return "MONDAY"
        case .TUESDAY:
            return "TUESDAY"
        case .WEDNESDAY:
            return "WEDNESDAY"
        case .THURSDAY:
            return "THURSDAY"
        case .FRIDAY:
            return "FRIDAY"
        case .SATURDAY:
            return "SATURDAY"
        case .SUNDAY:
            return "SUNDAY"
        }
    }
    
    public var stringValue: String {
        switch self {
            
        case .MONDAY:
            return "월"
        case .TUESDAY:
            return "화"
        case .WEDNESDAY:
            return "수"
        case .THURSDAY:
            return "목"
        case .FRIDAY:
            return "금"
        case .SATURDAY:
            return "토"
        case .SUNDAY:
            return "일"
        }
    }
    
    private var sortOrder: Int {
        switch self {
            
        case .MONDAY:
            return 0
        case .TUESDAY:
            return 1
        case .WEDNESDAY:
            return 2
        case .THURSDAY:
            return 3
        case .FRIDAY:
            return 4
        case .SATURDAY:
            return 5
        case .SUNDAY:
            return 6
        }
    }
    
    static func ==(lhs: Days, rhs: Days) -> Bool {
        return lhs.sortOrder == rhs.sortOrder
    }
    
    static func <(lhs: Days, rhs: Days) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }
}
