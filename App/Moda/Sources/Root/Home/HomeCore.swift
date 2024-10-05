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
    var currentDate: HomeDate = HomeDate.today
    var dates: [HomeDate] = DateManager.shared.homeDatas(from: .today)

    var monthlyTodos: [Todo] = []
    var dailyTodos: [Todo] = []
    var editingTodo: Todo?

    var isMonthlyFolded: Bool = true
    var isInitialMonthlyLoaded: Bool = false

    var isMonthlyEditing: Bool = false
    var isDailyEditing: Bool = false

    var todoCategory: Todo.Category = .monthly

    var isDeleteTodoBottomSheetPresented: Bool = false
    var isDelayTodoBottomSheetPresented: Bool = false

    var showNotice: Bool = false

    var isEditing: Bool {
      isMonthlyEditing || isDailyEditing
    }
  }

  enum Action: ViewAction {
    case showNotice
    case updateTodoCategory(Todo.Category)
    case view(View)

    enum View: BindableAction {
      case binding(BindingAction<State>)
      case onTask

      case monthChanged(Int)
      case monthTapped

      case dateTapped(HomeDate)

      case todoAdded(Todo.Category, String)
      case todoCategoryTapped(Todo.Category)
      case todoDeleted(Todo)
      case todoDelayed(Todo, Date)

      case monthlyEditTapped
      case monthlyTodosUpdated([Todo])

      case dailyEditTapped
      case dailyTodosUpdated([Todo])
    }
  }

  @Dependency(\.userData) var userData: UserData

  var body: some Reducer<State, Action> {
    BindingReducer(action: \.view)
    Reduce<State, Action> { state, action in
      switch action {
      case .showNotice:
        state.showNotice = true
        return .none

      case let .updateTodoCategory(category):
        state.todoCategory = category
        return .none

      case let .view(viewAction):
        switch viewAction {
        case .onTask:
          return .run { send in
            let showNotice = await userData.showNotice.value
            let category = await userData.todoCategory.value

            if showNotice {
              await send(.showNotice)
            }
            await send(.updateTodoCategory(category))
          }

        case let .monthChanged(cnt):
          let dates = DateManager.shared.homeDatas(from: state.currentDate.date.addMonth(cnt))
          state.dates = dates
          state.currentDate = dates.first!
          return .none

        case .monthTapped:
          let dates = DateManager.shared.homeDatas(from: .today)
          state.dates = dates
          state.currentDate = HomeDate.today
          return .none

        case let .dateTapped(date):
          state.currentDate = date
          return .none

        case let .todoAdded(category, todo):
          switch category {
          case .monthly:
            var updatedTodos = state.monthlyTodos
            let updatingIdx = updatedTodos.firstIndex(where: { $0.isDone })
            let todo = Todo(content: todo, category: category)
            if let updatingIdx {
              updatedTodos.insert(todo, at: updatingIdx)
            } else {
              updatedTodos.append(todo)
            }
            state.monthlyTodos = updatedTodos
            return .none

          case .daily:
            var updatedTodos = state.dailyTodos
            let updatingIdx = updatedTodos.firstIndex(where: { $0.isDone })
            let todo = Todo(content: todo, category: category)
            if let updatingIdx {
              updatedTodos.insert(todo, at: updatingIdx)
            } else {
              updatedTodos.append(todo)
            }
            state.monthlyTodos = updatedTodos
            return .none
          }

        case let .todoCategoryTapped(category):
          state.todoCategory = category
          return .run { send in
            await userData.todoCategory.update(category)
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
          state.isInitialMonthlyLoaded = true
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
