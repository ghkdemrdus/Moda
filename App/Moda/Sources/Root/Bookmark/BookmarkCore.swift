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
    var bookmarks: [Bookmark] = [.gameMock, .travelMock]

    var addedBookmark: Bookmark?
    var addedTodo: BookmarkTodo?

    var isEditPresented: Bool = false

    var edit: BookmarkEditCore.State = .init(bookmarks: [.gameMock, .travelMock])
  }

  enum Action: ViewAction {
    case view(View)
    case edit(BookmarkEditCore.Action)

    enum View: BindableAction {
      case binding(BindingAction<State>)
      case onTask
      case updateBookmarks([Bookmark])
      case todoTapped(Bookmark, BookmarkTodo)
      case todoAddTapped(Bookmark)
      case todoAdded(Bookmark, BookmarkTodo)
      case editTapped
    }
  }

  @Dependency(\.userData) var userData: UserData

  var body: some Reducer<State, Action> {
    Scope(state: \.edit, action: \.edit) {
      BookmarkEditCore()
    }
    BindingReducer(action: \.view)
    Reduce<State, Action> { state, action in
      switch action {
      case let .view(viewAction):
        switch viewAction {
        case .onTask:
          return .none

        case let .updateBookmarks(bookmarks):
          state.bookmarks = bookmarks
          state.edit = .init(bookmarks: bookmarks)
          return .none

        case let .todoTapped(bookmark, todo):
          todo.isDone.toggle()
          todo.doneDate = .today
          let updatedTodos = bookmark.todos.updating(todo: todo)
          withAnimation(.spring(duration: 0.4)) {
            bookmark.todos = updatedTodos
          }
          return .none

        case let .todoAddTapped(bookmark):
          state.addedBookmark = bookmark
          state.addedTodo = .init(content: "")
          return .none

        case let .todoAdded(bookmark, todo):
          let updatedTodos = bookmark.todos.updating(todo: todo)
          state.addedBookmark = nil
          state.addedTodo = nil
          withAnimation(.spring(duration: 0.4)) {
            bookmark.todos = updatedTodos
          }
          return .none

        default:
          return .none
        }

      case let .edit(childAction):
        switch childAction {
        case let .view(.doneTapped(bookmarks)):
          state.isEditPresented = false

          let updating = bookmarks.updating()
          state.edit = .init(bookmarks: updating)
          state.bookmarks = updating
          return .none

        default:
          return .none
        }
      }
    }
  }
}
