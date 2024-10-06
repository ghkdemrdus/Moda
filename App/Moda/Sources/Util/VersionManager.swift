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
    guard lastVersion < version else { return }

    migrateTodos.send(lastVersion < "1.0.4")

    await userData.showNotice.update(true)
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
