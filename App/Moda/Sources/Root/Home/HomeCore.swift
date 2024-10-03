//
//  HomeCore.swift
//  Moda
//
//  Created by 황득연 on 9/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation
import ComposableArchitecture
import _SwiftData_SwiftUI
import SwiftUI
import SwiftData

@Reducer
struct Home: Reducer {

  @ObservableState
  struct State: Equatable {
    var currentDate: HomeDate = .init(date: .today, timeline: .current, hasTodo: false)
    var dates: [HomeDate] = DateManager.shared.homeDatas(from: .today)

    var monthlyTodos: [Todo] = []
    var dailyTodos: [Todo] = []
    var editingTodo: Todo?

    var isMonthlyFolded: Bool = true

    var isMonthlyEditing: Bool = false
    var isDailyEditing: Bool = false

    var isDeleteTodoBottomSheetPresented = false
    var isDelayTodoBottomSheetPresented = false

    var isEditing: Bool {
      isMonthlyEditing || isDailyEditing
    }
  }

  enum Action: ViewAction {
    case view(View)

    enum View: BindableAction {
      case binding(BindingAction<State>)
      case monthChanged(Int)

      case todoAdded(Todo.Category, String)
      case todoDeleted(Todo)
      case todoDelayed(Todo, Date)

      case monthlyEditTapped
      case monthlyTodosUpdated([Todo])

      case dailyEditTapped
      case dailyTodosUpdated([Todo])
    }
  }

  var body: some Reducer<State, Action> {
    BindingReducer(action: \.view)
    Reduce<State, Action> { state, action in
      switch action {
      case let .view(viewAction):
        switch viewAction {
        case let .monthChanged(cnt):
          let dates = DateManager.shared.homeDatas(from: state.currentDate.date.addMonth(cnt))
          state.dates = dates
          state.currentDate = dates.first!
          return .none

        case let .todoAdded(category, todo):
          switch category {
          case .monthly:
            state.monthlyTodos += [.init(id: todo, content: todo, isDone: false, category: category)]
            return .none

          case .daily:
            state.dailyTodos += [.init(id: todo, content: todo, isDone: false, category: category)]
            return .none
          }

        case let .todoDeleted(todo), let .todoDelayed(todo, _):
          switch todo.category {
          case .monthly:
            state.monthlyTodos = state.monthlyTodos.filter { $0 != todo }

          case .daily:
            state.dailyTodos = state.dailyTodos.filter { $0 != todo }
          }
          return .none

        case let .monthlyTodosUpdated(todos):
          state.monthlyTodos = todos
          return .none

        case let .dailyTodosUpdated(todos):
          state.dailyTodos = todos
          return .none

        case .monthlyEditTapped:
          state.isMonthlyEditing = true
          return .none

        case .dailyEditTapped:
          state.isDailyEditing = true
          return .none

        default:
          return .none
        }
      }
    }
  }
}
