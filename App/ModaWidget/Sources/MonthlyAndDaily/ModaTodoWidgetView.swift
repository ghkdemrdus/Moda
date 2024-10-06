//
//  ModaTodoWidgetView.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/9/24.
//

import SwiftUI
import WidgetKit
import SwiftData

struct ModaTodoWidgetView : View {
  var entry: ModaTodoProvider.Entry
  @Query var monthlyTodosList: [MonthlyTodos]
  @Query var dailyTodosList: [DailyTodos]

  var body: some View {
    VStack(spacing: 0) {
      if isEmpty || isAllDone {
        HStack {
          Text("먼쓸리&데일리 투두")
            .font(.spoqaHans(size: 19, weight: .bold))
            .foregroundColor(Color.slate900)

          Spacer()
        }

        VStack(spacing: 8) {
          if isEmpty {
            Image.imgWidgetEmpty
          } else {
            Image.imgWidgetDone
          }

          Text(isEmpty ? "아직 해야할 일이 없어요\n새롭게 추가해볼까요?" : "해야할 일을 다 끝냈어요!\nNicely done 🎉")
            .font(.spoqaHans(size: 14))
            .foregroundColor(Color.fogOrange)
            .multilineTextAlignment(.center)
        }
        .frame(maxHeight: .infinity)
      } else {
        if !notDoneMonthlyTodos.isEmpty {
          VStack(spacing: 12) {
            HStack {
              Text("먼쓸리 투두")
                .font(.spoqaHans(size: 19, weight: .bold))
                .foregroundColor(Color.slate900)

              Spacer()

              ModaCountView(totalCount: monthlyTodos.count, doneCount: doneMonthlyTodos.count)
            }

            ForEach(notDoneMonthlyTodos.prefix(prefixOfMonthlyTodos), id: \.id) { todo in
              HStack(alignment: .center, spacing: 8) {
                Image.imgWidgetMonthlyTodo

                Text(todo.content)
                  .font(.spoqaHans(size: 15))
                  .foregroundColor(Color.slate800)
                  .frame(maxWidth: .infinity, alignment: .leading)
              }
              .frame(height: 24)
              .frame(maxWidth: .infinity)
            }
          }
        }

        if !notDoneMonthlyTodos.isEmpty && !notDoneDailyTodos.isEmpty {
          Spacer().frame(height: 16)
        }

        if !notDoneDailyTodos.isEmpty {
          VStack(spacing: 12) {
            HStack {
              Text("데일리 투두")
                .font(.spoqaHans(size: 19, weight: .bold))
                .foregroundStyle(Color.slate900)

              Spacer()

              ModaCountView(totalCount: dailyTodos.count, doneCount: doneDailyTodos.count)
            }

            ForEach(notDoneDailyTodos.prefix(prefixOfDailyTodos), id: \.id) { todo in
              HStack(alignment: .center, spacing: 8) {
                Image.imgWidgetMonthlyTodo

                Text(todo.content)
                  .font(.spoqaHans(size: 15))
                  .foregroundStyle(Color.slate800)
                  .frame(maxWidth: .infinity, alignment: .leading)
              }
              .frame(height: 24)
              .frame(maxWidth: .infinity)
            }
          }
        }
      }

      Spacer()
    }
    .containerBackground(for: .widget) {
      Color.orange200
    }
  }
}

// MARK: - Properties

private extension ModaTodoWidgetView {
  var monthlyTodos: [HomeTodo] {
    let todos = monthlyTodosList.first { $0.id == Date.today.format(.monthlyId) }?.todos
    return todos?.sorted { $0.order < $1.order } ?? []
  }

  var doneMonthlyTodos: [HomeTodo] {
    monthlyTodos.filter { $0.isDone }
  }

  var notDoneMonthlyTodos: [HomeTodo] {
    monthlyTodos.filter { !$0.isDone }
  }

  var dailyTodos: [HomeTodo] {
    let todos = dailyTodosList.first { $0.id == Date.today.format(.dailyId) }?.todos
    return todos?.sorted { $0.order < $1.order } ?? []
  }

  var doneDailyTodos: [HomeTodo] {
    dailyTodos.filter { $0.isDone }
  }

  var notDoneDailyTodos: [HomeTodo] {
    dailyTodos.filter { !$0.isDone }
  }

  var isEmpty: Bool {
    monthlyTodos.count == 0 && dailyTodos.count == 0
  }

  var isAllDone: Bool {
    if monthlyTodos.allSatisfy({ $0.isDone }) && dailyTodos.allSatisfy({ $0.isDone }) {
      return true
    }

    if monthlyTodos.allSatisfy({ $0.isDone }) && dailyTodos.count == 0 {
      return true
    }

    if dailyTodos.allSatisfy({ $0.isDone }) && monthlyTodos.count == 0 {
      return true
    }

    return false
  }

  var prefixOfMonthlyTodos: Int {
    if notDoneDailyTodos.count == 0 {
      return 8
    }

    if notDoneMonthlyTodos.count + notDoneDailyTodos.count <= 7 {
      return notDoneMonthlyTodos.count
    }

    if notDoneDailyTodos.count >= 3 {
      return max(3, 7 - notDoneDailyTodos.count)
    }

    return notDoneMonthlyTodos.count
  }

  var prefixOfDailyTodos: Int {
    if notDoneMonthlyTodos.count == 0 {
      return 8
    }

    return 7 - prefixOfMonthlyTodos
  }
}
