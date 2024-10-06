//
//  UserDfaultsManager.swift
//  Moda
//
//  Created by 황득연 on 10/4/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation

protocol UserDefaultsManaging {
  func store<T: Encodable>(key: UserDataKey, value: T)
  func get<T: Decodable>(key: UserDataKey, type: T.Type) -> T?
  func remove(key: UserDataKey)
  func removeAll()
}

public struct UserDefaultsManager: UserDefaultsManaging {
  static let shared: UserDefaultsManaging = UserDefaultsManager()
  private init() {}

  private let userDefaults = UserDefaults(suiteName: Bundle.main.groupId)!

  func store<T: Encodable>(key: UserDataKey, value: T) {
    let encodedData = try? JSONEncoder().encode(value)
    userDefaults.set(encodedData, forKey: key.rawValue)
  }

  func get<T: Decodable>(key: UserDataKey, type: T.Type) -> T? {
    guard let savedData = userDefaults.data(forKey: key.rawValue) else { return nil }
    do {
        let data = try JSONDecoder().decode(type.self, from: savedData)
        return data
    } catch {
        return nil
    }
  }

  func remove(key: UserDataKey) {
    userDefaults.removeObject(forKey: key.rawValue)
  }

  func removeAll() {
    UserDataKey.allCases.forEach {
      self.remove(key: $0)
    }
  }
}
