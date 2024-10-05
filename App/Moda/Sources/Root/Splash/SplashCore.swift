//
//  SplashCore.swift
//  Moda
//
//  Created by 황득연 on 9/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
struct Splash: Reducer {

  @ObservableState
  struct State: Equatable {}

  enum Action: ViewAction {
    case view(View)

    enum View: BindableAction {
      case binding(BindingAction<State>)
      case timeout
    }
  }

  @Dependency(\.userData) var userData: UserData

  var body: some Reducer<State, Action> {
    Reduce<State, Action> { state, action in
      switch action {
      case .view(let action):
        switch action {
        case .timeout:
          return .run { send in
            await userData.lastVersion.update(Bundle.main.version)
          }

        default:
          return .none
        }
      }
    }
  }
}
