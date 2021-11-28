//
//  Environment.swift
//  Habit
//
//  Created by hansol on 2021/11/28.
//

import Foundation

// MARK: - Environment

struct Environment {
    
    static let baseURL = (Bundle.main.infoDictionary?["BASE_URL"] as! String).replacingOccurrences(of: " ", with: "")
}

