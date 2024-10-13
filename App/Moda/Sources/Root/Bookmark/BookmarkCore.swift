//
//  BookmarkCore.swift
//  Moda
//
//  Created by 황득연 on 10/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation
import ComposableArchitecture
import SwiftUI
import SwiftData

@Reducer
struct BookmarkCore: Reducer {

  @ObservableState
  struct State: Equatable {
    var currentDate: Date = .today
    var isInitialLoaded: Bool = false
    var bookmarks: [Bookmark] = [.travelMock, .gameMock]
  }

  enum Action: ViewAction {
    case showAppReviewBanner
    case view(View)

    enum View: BindableAction {
      case binding(BindingAction<State>)
      case onTask
      case updateBookmarks([Bookmark])
    }
  }

  @Dependency(\.userData) var userData: UserData

  var body: some Reducer<State, Action> {
    BindingReducer(action: \.view)
    Reduce<State, Action> { state, action in
      switch action {
      case .showAppReviewBanner:
        return .none

      case let .view(viewAction):
        switch viewAction {
        case .onTask:
          return .run { send in
          }

        case let .updateBookmarks(bookmarks):
          state.bookmarks = bookmarks
          return .none

        default:
          return .none
        }
      }
    }
  }
}
