//
//  UserDefaultHandler.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/02.
//

import Foundation

class UserDefaultHandler {
    
  static var accessToken: String? {
    return UserDefaultHelper<String>.value(forKey: .accessToken)
  }
  
  static var refreshToken: String? {
    return UserDefaultHelper<String>.value(forKey: .refreshToken)
  }
    
  static var loginType: String? {
    return UserDefaultHelper<String>.value(forKey: .loginType)
  }
  
  static var userId: Int? {
    return UserDefaultHelper<Int>.value(forKey: .userId)
  }
}

class UserDefaultHelper<T> {
  class func value(forKey key: UserData) -> T? {
    if let data = UserDefaults.standard.value(forKey : key.rawValue) as? T {
      return data
    }
    else {
      return nil
    }
  }

  class func value(forkey key: UserData) -> [T]? {
    if let data = UserDefaults.standard.array(forKey: key.rawValue) as? [T]? {
      return data
    }
    else {
      return nil
    }
  }

  class func set(_ value: T, forKey key: UserData) {
    UserDefaults.standard.set(value, forKey : key.rawValue)
  }
  
  class func set(_ value: [T], forKey key: UserData) {
    UserDefaults.standard.set(value, forKey : key.rawValue)
  }
  
  class func clearAll() {
    UserDefaults.standard.dictionaryRepresentation().keys.forEach { key in
      UserDefaults.standard.removeObject(forKey: key.description)
    }
  }
}
