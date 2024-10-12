//
//  HomeCore.swift
//  Moda
//
//  Created by 황득연 on 9/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation
import ComposableArchitecture
import SwiftUI
import SwiftData

@Reducer
struct Home: Reducer {

  @ObservableState
  struct State: Equatable {
    var currentDate: HomeDate = HomeDate.today
    var dates: [HomeDate] = DateManager.shared.homeDatas(from: .today)

    var monthlyTodos: [HomeTodo] = []
    var dailyTodos: [HomeTodo] = []
    var editingTodo: HomeTodo?

    var isMonthlyFolded: Bool = true
    var isInitialMonthlyLoaded: Bool = false

    var isMonthlyEditing: Bool = false
    var isDailyEditing: Bool = false

    var todoCategory: HomeTodo.Category = .monthly

    var isDeleteTodoBottomSheetPresented: Bool = false
    var isDelayTodoBottomSheetPresented: Bool = false

    var showNotice: Bool = false
    var showAppReviewBanner: Bool = false

    var isEditing: Bool {
      isMonthlyEditing || isDailyEditing
    }
  }

  enum Action: ViewAction {
    case showNotice
    case showAppReviewBanner
    case updateTodoCategory(HomeTodo.Category)
    case view(View)

    enum View: BindableAction {
      case binding(BindingAction<State>)
      case onTask

      case monthChanged(Int)
      case monthTapped

      case dateTapped(HomeDate)

      case todoAdded(HomeTodo.Category, String)
      case todoCategoryTapped(HomeTodo.Category)
      case todoDeleted(HomeTodo)
      case todoDelayed(HomeTodo, Date)

      case monthlyEditTapped
      case monthlyTodoDoneTapped(HomeTodo)
      case monthlyTodosUpdated([HomeTodo])
      case monthlyTodosReordered([HomeTodo])

      case dailyEditTapped
      case dailyTodoDoneTapped(HomeTodo)
      case dailyTodosUpdated([HomeTodo])
      case dailyTodosReordered([HomeTodo])

      case hideAppReviewBanner
      case reviewConfirmTapped
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

      case .showAppReviewBanner:
        state.showAppReviewBanner = true
        return .none

      case let .updateTodoCategory(category):
        state.todoCategory = category
        return .none

      case let .view(viewAction):
        switch viewAction {
        case .onTask:
          return .run { send in
            let showNotice = await userData.showNotice.value
            let showAppReviewBanner = await userData.showAppReviewBanner.value
            let category = await userData.todoCategory.value

            if showNotice {
              await send(.showNotice)
            }
            if showAppReviewBanner {
              try? await Task.sleep(for: .seconds(0.5))
              await send(.showAppReviewBanner)
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

        case let .todoAdded(category, content):
          let content = content.trimmingCharacters(in: .whitespacesAndNewlines)
          if content.isEmpty { return .none }

          switch category {
          case .monthly:
            let todo = HomeTodo(content: content, category: .monthly)
            let updatedTodos = state.monthlyTodos.updating(todo: todo)
            state.monthlyTodos = updatedTodos
            return .none

          case .daily:
            let todo = HomeTodo(content: content, category: .daily)
            let updatedTodos = state.dailyTodos.updating(todo: todo)
            state.dailyTodos = updatedTodos
            return .none
          }

        case let .todoCategoryTapped(category):
          state.todoCategory = category
          return .run { send in
            await userData.todoCategory.update(category)
          }

        case let .todoDeleted(todo):
          switch todo.category {
          case .monthly:
            state.monthlyTodos = state.monthlyTodos.filter { $0.id != todo.id }
            state.dailyTodos = state.dailyTodos.filter { $0.id != todo.id }
          case .daily:
            state.dailyTodos = state.dailyTodos.filter { $0.id != todo.id }
          }
          return .run { send in
            await ModaToastManager.shared.show(.deleteTodo)
          }

        case let .todoDelayed(todo, _):
          switch todo.category {
          case .monthly:
            state.monthlyTodos = state.monthlyTodos.filter { $0.id != todo.id }
            state.dailyTodos = state.dailyTodos.filter { $0.id != todo.id }
          case .daily:
            state.dailyTodos = state.dailyTodos.filter { $0.id != todo.id }
          }
          return .run { send in
            await ModaToastManager.shared.show(.delayTodo)
          }

        case let .monthlyTodoDoneTapped(todo):
          todo.isDone.toggle()
          let updatedTodos = state.monthlyTodos.updating(todo: todo)
          withAnimation(.spring(duration: 0.4)) {
            state.monthlyTodos = updatedTodos
          }

          return .run { [todo] send in
            if todo.isDone {
              await ModaToastManager.shared.show(.doneTodo)
            }
          }

        case let .monthlyTodosUpdated(todos):
          state.monthlyTodos = todos.sorted { $0.order < $1.order }
          state.isInitialMonthlyLoaded = true
          return .none

        case let .monthlyTodosReordered(todos):
          state.monthlyTodos = todos.updating()
          return .none

        case let .dailyTodoDoneTapped(todo):
          todo.isDone.toggle()
          let updatedTodos = state.dailyTodos.updating(todo: todo)
          withAnimation(.spring(duration: 0.4)) {
            state.dailyTodos = updatedTodos
          }

          return .run { [todo] send in
            if todo.isDone {
              await ModaToastManager.shared.show(.doneTodo)
            }
          }

        case let .dailyTodosUpdated(todos):
          state.dailyTodos = todos.sorted { $0.order < $1.order }
          return .none

        case let .dailyTodosReordered(todos):
          state.dailyTodos = todos.updating()
          return .none

        case .monthlyEditTapped:
          state.isMonthlyEditing = true
          return .none

        case .dailyEditTapped:
          state.isDailyEditing = true
          return .none

        case .hideAppReviewBanner:
          state.showAppReviewBanner = false
          return .none

        case .reviewConfirmTapped:
          openAppReview()
          return .send(.view(.hideAppReviewBanner))

        default:
          return .none
        }
      }
    }
  }

  private func openAppReview() {
    let url = "https://apps.apple.com/app/id6444545964?action=write-review"
    guard let writeReviewURL = URL(string: url) else { fatalError("Expected a valid URL") }

    UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
  }
}
