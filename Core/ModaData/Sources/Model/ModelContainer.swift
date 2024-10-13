//
//  ModelContainer.swift
//  ModaCore
//
//  Created by 황득연 on 10/5/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftData
import Foundation

public var todoModelContainer: ModelContainer = {
  let schema = Schema([MonthlyTodos.self, DailyTodos.self, HomeTodo.self, Bookmark.self])
  let configuration = ModelConfiguration(schema: schema, url: storeURL, cloudKitDatabase: .none)
  do {
    return try ModelContainer(for: schema, configurations: [configuration])
  } catch {
    fatalError("Could not create ModelContainer: \(error)")
  }
}()

public var storeURL: URL {
  let fileManager = FileManager.default

  guard let appGroupURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: Bundle.main.groupId) else {
    fatalError("Could not find app group URL")
  }

#if DEBUG
  let filename = "ModaTodo-Debug.sqlite"
#else
  let filename = "ModaTodo.sqlite"
#endif

  return appGroupURL.appendingPathComponent(filename)
}
