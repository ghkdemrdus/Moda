//
//  MainTabCore.swift
//  Moda
//
//  Created by 황득연 on 10/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

typealias MainTab = MainTabCore.MainTab

@Reducer
struct MainTabCore: Reducer {

  enum MainTab: CaseIterable {
    case bookmark, home, setting
  }

  @ObservableState
  struct State: Equatable {
    var selectedTab: MainTab = .home
    var isBlured: Bool = false

    var home: HomeCore.State = .init()
    var bookmark: BookmarkCore.State = .init()
    var setting: SettingCore.State = .init()
  }

  enum Action: ViewAction {
    case home(HomeCore.Action)
    case bookmark(BookmarkCore.Action)
    case setting(SettingCore.Action)

    case view(View)

    enum View: BindableAction {
      case binding(BindingAction<State>)
      case onTask
    }
  }

  var body: some Reducer<State, Action> {
    BindingReducer(action: \.view)
    Scope(state: \.home, action: \.home) { HomeCore() }
    Scope(state: \.bookmark, action: \.bookmark) { BookmarkCore() }
    Scope(state: \.setting, action: \.setting) { SettingCore() }

    Reduce<State, Action> { state, action in
      switch action {

        // Bookmark
      case let .bookmark(action):
        switch action {
        case .view(.binding(.set(\.isEditPresented, true))):
          state.isBlured = true
          return .none

        case .edit(.view(.doneTapped)):
          state.isBlured = false
          return .none

        default:
          return .none
        }

      default:
        return .none
      }
    }
  }
}

extension MainTab {
  // FIXME: 임의로 넣어놓은거라 나중에 제거할 것
  var image: Image {
    switch self {
    case .bookmark: return .icDelete
    case .home: return .icClear
    case .setting: return .icCheckGreen
    }
  }
}
