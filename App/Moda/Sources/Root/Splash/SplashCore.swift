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

  enum Action {
    case timeout
  }

  var body: some Reducer<State, Action> {
    Reduce<State, Action> { state, action in
      return .none
    }
  }
}
