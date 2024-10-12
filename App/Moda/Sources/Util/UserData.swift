//
//  UserData.swift
//  Moda
//
//  Created by 황득연 on 10/4/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation
import ComposableArchitecture


enum UserDataKey: String, CaseIterable {
  case launchDates
  case todoInputCategory
  case lastVersion
  case todoCategory
  case showNotice
  case showAppReviewBanner
  case didAppReviewBannerShown
}

public final class UserData {
  public let launchDates = DataStorage<Set<String>>(key: .launchDates, defaultValue: .init())
  public let todoInputCategory = DataStorage<HomeTodo.Category>(key: .todoInputCategory, defaultValue: .monthly)
  public let lastVersion = DataStorage<String?>(key: .lastVersion, defaultValue: nil)
  public let todoCategory = DataStorage<HomeTodo.Category>(key: .todoCategory, defaultValue: .monthly)
  public let showNotice = DataStorage<Bool>(key: .showNotice, defaultValue: false)
  public let showAppReviewBanner = DataStorage<Bool>(key: .showAppReviewBanner, defaultValue: false)
  public let didAppReviewBannerShown = DataStorage<Bool>(key: .didAppReviewBannerShown, defaultValue: false)
}

public extension UserData {
  func reset() async {
    await removeAll(self)
  }

  private func removeAll(_ target: Any) async {
      for c in Mirror(reflecting: target).children {
          if let instance = c.value as? Removable {
              await instance.remove()
          }
      }
  }
}

extension DependencyValues {
  var userData: UserData {
    get { self[UserData.self] }
    set { self[UserData.self] = newValue }
  }
}

extension UserData: DependencyKey {
  public static let liveValue = UserData()
}
