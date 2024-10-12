//
//  Bundle+Extension.swift
//  Moda
//
//  Created by 황득연 on 10/4/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation
import ComposableArchitecture
import Combine

public final class VersionManager {

  @Dependency(\.userData) var userData

  public let migrateTodos = CurrentValueSubject<Bool?, Never>(false)

  func onUpgrate() async {
    let version = Bundle.main.version
    let lastVersion = await userData.lastVersion.value
    var launchDates = await userData.launchDates.value
    let didAppReviewBannerShown = await userData.didAppReviewBannerShown.value

    launchDates.insert(Date.today.format(.monthlyId))
    await userData.launchDates.update(launchDates)

    if lastVersion < "1.0.4" {
      migrateTodos.send(true)
    }

    if !didAppReviewBannerShown && (lastVersion < "1.1.0" || launchDates.count == 3) {
      await userData.showAppReviewBanner.update(true)
      await userData.didAppReviewBannerShown.update(true)
    }

    if launchDates.count == 10 {
      await userData.showAppReviewBanner.update(true)
    }

    await userData.showNotice.update(lastVersion < version)
    await userData.lastVersion.update(version)
  }
}

// MARK: - Dependency

extension DependencyValues {
  var versionManager: VersionManager {
    get { self[VersionManager.self] }
    set { self[VersionManager.self] = newValue }
  }
}

extension VersionManager: DependencyKey {
  public static let liveValue = VersionManager()
}
