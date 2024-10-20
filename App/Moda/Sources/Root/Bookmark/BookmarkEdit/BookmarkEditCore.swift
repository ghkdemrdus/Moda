//
//  BookmarkEditCore.swift
//  Moda
//
//  Created by 황득연 on 10/17/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import ComposableArchitecture

@Reducer
struct BookmarkEditCore: Reducer {

  @ObservableState
  struct State: Equatable {
    var bookmarks: [Bookmark]
    var updatedBookmarks: [Bookmark] = []
  }

  enum Action: ViewAction {
    case view(View)
    case bookmarkDeleted(Bookmark)

    enum View: BindableAction {
      case binding(BindingAction<State>)
      case onTask
      case addTapped
      case doneTapped([Bookmark])
      case deleteTapped(Bookmark)
    }
  }

  @Dependency(\.userData) var userData: UserData
  @Dependency(\.bottomSheet) var bottomSheet: BottomSheetClient

  var body: some Reducer<State, Action> {
    BindingReducer(action: \.view)
    Reduce<State, Action> { state, action in
      switch action {
      case let .view(viewAction):
        switch viewAction {
        case .onTask:
          return .run { send in
          }

        case .addTapped:
          var updated = state.updatedBookmarks
          updated.append(.init(title: ""))
          state.updatedBookmarks = updated.reordering()
          return .none

        case let .deleteTapped(bookmark):
          return .run { @MainActor send in
            await bottomSheet.show(.deleteTodo(content: bookmark.title), {
              send(.bookmarkDeleted(bookmark))
            })
          }

        default:
          return .none
        }

      case let .bookmarkDeleted(bookmark):
        state.bookmarks = state.bookmarks.filter { $0.id != bookmark.id }
        return .none
      }
    }
  }
}
