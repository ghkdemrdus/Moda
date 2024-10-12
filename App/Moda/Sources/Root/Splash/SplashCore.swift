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
  struct State: Equatable {
    var shouldMigrateTodos: Bool?

    var isTimeout: Bool = false
    var isMigrationFinished: Bool = false
  }

  enum Action: ViewAction {
    case view(View)
    case migrateTodos(Bool?)
    case timeout

    enum View: BindableAction {
      case binding(BindingAction<State>)
      case onTask
      case migrationFinished
      case splashFinished
    }
  }

  @Dependency(\.userData) var userData: UserData
  @Dependency(\.versionManager) var versionManager: VersionManager

  var body: some Reducer<State, Action> {
    Reduce<State, Action> { state, action in
      switch action {
      case .view(let action):
        switch action {
        case .onTask:
          return .merge(
            .run { send in
              // 업데이트 상황 체크
              async let upgradeTask: () = versionManager.onUpgrate()

              // 최소 1초 이상 스플래시 보장
              async let sleepTask: ()? = try? await Task.sleep(for: .seconds(1))

              let _ = await (upgradeTask, sleepTask)
              await send(.timeout)
            },
            .publisher {
              versionManager.migrateTodos
                .map(Action.migrateTodos)
            }
          )

        case .migrationFinished:
          state.isMigrationFinished = true
          return .none

        default:
          return .none
        }

      case .timeout:
        state.isTimeout = true
        return .none

      case let .migrateTodos(shouldMigrate):
        state.shouldMigrateTodos = shouldMigrate
        return .none
      }
    }
  }
}
