//
//  Encodable+.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/02.
//

import Foundation

// MARK: - Encodable Extension

extension Encodable {
    
  func asParameter() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            as? [String: Any] else {
      throw NSError()
    }
    
    return dictionary
  }
}
