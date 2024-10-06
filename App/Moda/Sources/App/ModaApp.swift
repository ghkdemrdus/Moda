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

  var body: some Scene {
    WindowGroup {
      RootView()
        .modelContainer(defaultModelContainer)
        .onFirstAppear {
          UITextField.appearance().tintColor = UIColor(.brandStrong)
          WidgetCenter.shared.reloadAllTimelines()
        }
        .onBackground {
          WidgetCenter.shared.reloadAllTimelines()
          try? defaultModelContainer.mainContext.save()
        }
    }
  }
}
