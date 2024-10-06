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
  let schema = Schema([MonthlyTodos.self, DailyTodos.self, HomeTodo.self])
  let configuration = ModelConfiguration(schema: schema, url: storeURL, cloudKitDatabase: .none)
  do {
    return try ModelContainer(for: schema, configurations: [configuration])
  } catch {
    fatalError("Could not create ModelContainer: \(error)")
  }
}()

@MainActor
public var previewContainer: ModelContainer = {
  do {
    let schema = Schema([MonthlyTodos.self, DailyTodos.self, HomeTodo.self])
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: schema, configurations: configuration)

    let monthlyTodos = MonthlyTodos(
      id: Date.today.format(.monthlyId),
      todos: [
        .init(id: "0", order: 0, content: "Todo1", isDone: false, category: .monthly),
        .init(id: "1", order: 1, content: "Todo2", isDone: false, category: .monthly),
        .init(id: "2", order: 2, content: "Todo3", isDone: false, category: .monthly)
      ]
    )

    let dailyTodos = DailyTodos(
      id: Date.today.format(.dailyId),
      todos: [
        .init(id: "10", order: 0, content: "Todo11", isDone: false, category: .daily),
        .init(id: "11", order: 1, content: "Todo22", isDone: false, category: .daily),
        .init(id: "12", order: 2, content: "Todo33", isDone: false, category: .daily)
      ]
    )

    container.mainContext.insert(monthlyTodos)
    container.mainContext.insert(dailyTodos)

    return container
  } catch {
    fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
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
