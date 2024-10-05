//
//  Bundle+Extension.swift
//  Moda
//
//  Created by 황득연 on 10/4/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation
import ComposableArchitecture

public final class VersionManager {

  @Dependency(\.userData) var userData

  func checkIsUpdated(version: String) async {
    let lastVersion = await userData.lastVersion.value
    await userData.showNotice.update(lastVersion < version)
    await userData.lastVersion.update(version)
  }

  func shouldMigrateTodoData(version: String) -> Bool {
      return version < "1.0.4"
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
