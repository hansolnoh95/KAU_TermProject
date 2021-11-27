//
//  Optional+.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/02.
//

import Foundation

// MARK: - Optional Extension

extension Optional {
    
  public var isNil: Bool {
    switch self {
    case .some:
      return false
    case .none:
      return true
    }
  }

  public var isNotNil: Bool {
    return !isNil
  }
}
