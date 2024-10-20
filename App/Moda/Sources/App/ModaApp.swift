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

  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      RootView()
        .globalToast()
        .globalBottomSheet()
        .modelContainer(todoModelContainer)
        .onAppear {
          UITextField.appearance().tintColor = UIColor(.brandStrong)
          UITextView.appearance().tintColor = UIColor(.brandStrong)
          UITextView.appearance().backgroundColor = .clear
          UITextView.appearance().textContainerInset = .zero
        }
        .onBackground {
          WidgetCenter.shared.reloadAllTimelines()
          try? todoModelContainer.mainContext.save()
        }
    }
  }
}
