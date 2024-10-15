//
//  SettingCore.swift
//  Moda
//
//  Created by 황득연 on 10/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct SettingCore: Reducer {
  @ObservableState
  struct State: Equatable {

  }

  enum Action: ViewAction {
    case view(View)

    enum View: BindableAction {
      case binding(BindingAction<State>)
      case onTask
    }
  }

  var body: some Reducer<State, Action> {
    BindingReducer(action: \.view)
    Reduce<State, Action> { state, action in
      switch action {
      case let .view(viewAction):
        return .none
      }
    }
  }
}
