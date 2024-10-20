//
//  BookmarkTodoEditCore.swift
//  Moda
//
//  Created by 황득연 on 10/19/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import ComposableArchitecture

@Reducer
struct BookmarkTodoEditCore: Reducer {

  @ObservableState
  struct State: Equatable {
    var bookmark: Bookmark
    var editingTodo: BookmarkTodo?
  }

  enum Action: ViewAction {
    case view(View)
    case todoDeleted(BookmarkTodo)

    enum View: BindableAction {
      case binding(BindingAction<State>)
      case onTask
      case onFirstAppear

      case doneTapped
      case editTapped(BookmarkTodo)
      case deleteTapped(BookmarkTodo)
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
        case let .deleteTapped(todo):
          return .run { @MainActor send in
            await bottomSheet.show(.deleteTodo(content: todo.content), {
              send(.todoDeleted(todo))
            })
          }

        case let .editTapped(todo):
          state.editingTodo = state.editingTodo == nil ? todo : nil
          return .none

        case .doneTapped:
          state.bookmark.todos = state.bookmark.todos.reordering()
          return .none

        default:
          return .none
        }

      case let .todoDeleted(todo):
        state.bookmark.todos = state.bookmark.todos.filter { $0.id != todo.id }
        return .none
      }
    }
  }
}
