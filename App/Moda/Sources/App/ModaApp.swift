//
//  ModaApp.swift
//  Moda
//
//  Created by 황득연 on 3/18/24.
//

import SwiftUI
import ComposableArchitecture
import SwiftData
import WidgetKit

@main
struct ModaApp: App {

//  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//  private var store: StoreOf<RootCore> { delegate.store }

  var modelContainer: ModelContainer = {
    let schema = Schema([MonthlyTodos.self, DailyTodos.self, Todo.self])
    let modelConfiguration = ModelConfiguration(schema: schema)

    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()

  var body: some Scene {
    WindowGroup {
      RootView()
        .modelContainer(modelContainer)
        .onFirstAppear {
          WidgetCenter.shared.reloadAllTimelines()
        }
        .onBackground {
          WidgetCenter.shared.reloadAllTimelines()
          try? modelContainer.mainContext.save()
        }
    }
  }
}
