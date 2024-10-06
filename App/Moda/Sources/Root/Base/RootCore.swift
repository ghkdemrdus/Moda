//
//  RootCore.swift
//  Moda
//
//  Created by 황득연 on 9/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
enum Root {
  case splash(Splash)
  case home(Home)

  static var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .splash(.view(.splashFinished)):
        state = .home(.init())
        return .none

      default:
        return .none
      }
    }
    .ifCaseLet(\.splash, action: \.splash) {
      Splash()
    }
    .ifCaseLet(\.home, action: \.home) {
      Home()
    }
  }
}
