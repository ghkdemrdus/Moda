//
//  DataStorage.swift
//  Moda
//
//  Created by 황득연 on 10/4/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Combine

public actor DataStorage<T: Codable> {
  private let userDefaultsManager: UserDefaultsManaging = UserDefaultsManager.shared
  private let key: UserDataKey
  private let defaultValue: T

  init(key: UserDataKey, defaultValue: T) {
    self.key = key
    self.defaultValue = defaultValue
  }

  var value: T {
    get {
      if let data = userDefaultsManager.get(key: key, type: T.self) {
        return data
      } else {
        return defaultValue
      }
    }
    set {
      userDefaultsManager.store(key: key, value: newValue)
    }
  }

  func update(_ value: T) {
    self.value = value
  }
}

extension DataStorage: Removable {
  func remove() {
    value = defaultValue
    userDefaultsManager.remove(key: key)
  }
}

protocol Removable {
  func remove() async
}
