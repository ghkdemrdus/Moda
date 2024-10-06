//
//  ModelContainer.swift
//  ModaCore
//
//  Created by 황득연 on 10/5/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftData
import Foundation

public var defaultModelContainer: ModelContainer = {
  let schema = Schema([MonthlyTodos.self, DailyTodos.self, HomeTodo.self])
  let modelConfiguration = ModelConfiguration(schema: schema, cloudKitDatabase: .none)
  do {
    return try ModelContainer(for: schema, configurations: [modelConfiguration])
  } catch {
    fatalError("Could not create ModelContainer: \(error)")
  }
}()

public var storeURL: URL {
  let fileManager = FileManager.default

#if DEBUG
  let groupIdentifier = "group.pinto.moda.debug"
#else
  let groupIdentifier = "group.pinto.moda"
#endif

  guard let appGroupURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: groupIdentifier) else {
    fatalError("앱 그룹 컨테이너를 찾을 수 없습니다.")
  }

#if DEBUG
  let filename = "ModaTodo-Debug.sqlite"
#else
  let filename = "ModaTodoTest1.sqlite"
#endif

  return appGroupURL.appendingPathComponent(filename)
}
