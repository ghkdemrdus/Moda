//
//  ModaApp.swift
//  Moda
//
//  Created by 황득연 on 3/18/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct ModaApp: App {

//  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//  private var store: StoreOf<RootCore> { delegate.store }

  @State var text: String = ""
  var body: some Scene {
    WindowGroup {
      RootView()
        .onAppear {
          FontUtil.registerCustomFonts()
        }
    }
  }
}
