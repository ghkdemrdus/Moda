//
//  ContentView.swift
//  Moda
//
//  Created by 황득연 on 3/18/24.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
  let store = Store(initialState: RootCore.State.splash(.init())) {
    RootCore.body
  }

  var body: some View {
    Group {
      switch store.case {
      case let .splash(store):
        SplashView(store: store)

      case let .mainTab(store):
        MainTabView(store: store)
      }
    }
  }
}
