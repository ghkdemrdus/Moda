//
//  HomeCore.swift
//  Moda
//
//  Created by 황득연 on 9/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
struct Home: Reducer {

  @ObservableState
  struct State: Equatable {
    var currentDate: HomeDate = .init(date: .today, timeline: .current, hasTodo: false)
    var dates: [HomeDate] = DateManager.shared.homeDatas(from: .today)
    var monthlyTodos: [Todo] = [
      .init(id: "51", content: "11111", isDone: false, type: .monthly),
      .init(id: "52", content: "111121", isDone: false, type: .monthly),
      .init(id: "53", content: "111131", isDone: false, type: .monthly),
      .init(id: "54", content: "111141", isDone: false, type: .monthly),
      .init(id: "55", content: "111151", isDone: false, type: .monthly),
      .init(id: "511", content: "11111", isDone: false, type: .monthly),
      .init(id: "521", content: "111121", isDone: false, type: .monthly),
      .init(id: "531", content: "111131", isDone: false, type: .monthly),
      .init(id: "541", content: "111141", isDone: false, type: .monthly),
      .init(id: "551", content: "111151", isDone: false, type: .monthly),
      .init(id: "512", content: "11111", isDone: false, type: .monthly),
      .init(id: "522", content: "111121", isDone: false, type: .monthly),
      .init(id: "532", content: "111131", isDone: false, type: .monthly),
      .init(id: "542", content: "111141", isDone: false, type: .monthly),
      .init(id: "552", content: "111151", isDone: false, type: .monthly),
    ]
    var dailyTodos: [Todo] = [
      .init(id: "1", content: "11111", isDone: false, type: .daily),
      .init(id: "2", content: "111121", isDone: false, type: .daily),
      .init(id: "3", content: "111131", isDone: false, type: .daily),
      .init(id: "4", content: "111141", isDone: false, type: .daily),
      .init(id: "5", content: "111151", isDone: false, type: .daily),
      .init(id: "11", content: "11111", isDone: false, type: .daily),
      .init(id: "21", content: "111121", isDone: false, type: .daily),
      .init(id: "31", content: "111131", isDone: false, type: .daily),
      .init(id: "41", content: "111141", isDone: false, type: .daily),
      .init(id: "51", content: "111151", isDone: false, type: .daily),
      .init(id: "12", content: "11111", isDone: false, type: .daily),
      .init(id: "22", content: "111121", isDone: false, type: .daily),
      .init(id: "32", content: "111131", isDone: false, type: .daily),
      .init(id: "42", content: "111141", isDone: false, type: .daily),
      .init(id: "52", content: "111151", isDone: false, type: .daily),
    ]
    var editingTodo: Todo?
    var optioningTodo: Todo?
  }

  enum Action: ViewAction {
    case view(View)

    enum View: BindableAction {
      case binding(BindingAction<State>)
      case monthChanged(Int)
      case todoAdded(Todo.`Type`, String)
      case todoDeleted(Todo)
    }
  }

  enum TodoOption: String, CaseIterable {
    case edit = "수정"
    case delete = "삭제"
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

        case let .todoAdded(type, todo):
          switch type {
          case .monthly:
            state.monthlyTodos += [.init(id: todo, content: todo, isDone: false, type: type)]
            return .none

          case .daily:
            state.dailyTodos += [.init(id: todo, content: todo, isDone: false, type: type)]
            return .none
          }

        case let .todoDeleted(todo):
          switch todo.type {
          case .monthly:
            state.monthlyTodos = state.monthlyTodos.filter { $0 != todo }

          case .daily:
            state.dailyTodos = state.dailyTodos.filter { $0 != todo }
          }
          return .none

        default:
          return .none
        }
      }
    }
  }
}
