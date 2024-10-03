//
//  ModaApp.swift
//  Moda
//
//  Created by 황득연 on 3/18/24.
//

import SwiftUI
import ComposableArchitecture
import SwiftData

@main
struct ModaApp: App {

//  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//  private var store: StoreOf<RootCore> { delegate.store }

  var modelContainer: ModelContainer = {
    let schema = Schema([MonthlyTodos.self, DailyTodos.self, Todo.self])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, cloudKitDatabase: .none)

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
        .onAppear {
          FontUtil.registerCustomFonts()
        }
    }
  }
}
