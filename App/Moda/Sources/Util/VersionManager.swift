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

  enum Constant {
    static let updateNoticeVersion: String = "1.0.4"
    static let appReviewBannerVersion: String = "1.1.0"
  }

  @Dependency(\.userData) var userData

  public let migrateTodos = CurrentValueSubject<Bool?, Never>(false)

  func onUpgrate() async {
    // FIXME: 1.1.0 버전에 한해서 초기화 시켜준다
    await userData.showNotice.remove()

    let version = Bundle.main.version
    let lastVersion = await userData.lastVersion.value
    var launchDates = await userData.launchDates.value
    let didAppReviewBannerShown = await userData.didAppReviewBannerShown.value

    // 버전과 관련없이 Upgrade되는 Task
    launchDates.insert(Date.today.format(.monthlyId))
    await userData.launchDates.update(launchDates)
    await userData.lastVersion.update(version)

    // 신규 유저는 아무런 Upgrade를 하지 않는다.
    guard let lastVersion else { return }

    if lastVersion < Constant.updateNoticeVersion {
      migrateTodos.send(true)
      await userData.showNotice.update(true)
    }

    if !didAppReviewBannerShown, lastVersion < Constant.appReviewBannerVersion || launchDates.count == 3 {
      await userData.showAppReviewBanner.update(true)
      await userData.didAppReviewBannerShown.update(true)
    }

    if launchDates.count == 10 {
      await userData.showAppReviewBanner.update(true)
    }
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
