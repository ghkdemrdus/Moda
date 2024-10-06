//
//  ModaWidgetView.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 2/27/24.
//

import SwiftUI
import WidgetKit
import SwiftData

struct ModaDailyWidgetView : View {
  var entry: ModaDailyProvider.Entry
  @Query var dailyTodosList: [DailyTodos]

  var body: some View {
    HStack(alignment: .top, spacing: 0) {
      VStack(alignment: .leading) {
        Text("데일리\n투두")
          .font(.spoqaHans(size: 19, weight: .bold))
          .foregroundStyle(Color.slate900)

        Spacer()

        if todos.count > 0 {
          ModaCountView(totalCount: todos.count, doneCount: doneTodos.count)
        }
      }

      if !todos.isEmpty && !isAllDone {
        VStack(spacing: 8) {
          ForEach(notDoneTodos, id: \.id) { todo in
            HStack(alignment: .center, spacing: 8) {
              Image.imgWidgetDailyTodo

              Text(todo.content)
                .font(.spoqaHans(size: 15))
                .foregroundStyle(Color.slate800)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 24)
            .frame(maxWidth: .infinity)
          }

          Spacer()
        }
        .padding(.leading, 12)
      } else {
        Spacer()
        VStack(spacing: 8) {
          if isAllDone {
            Image.imgWidgetMonthlyDone
          } else {
            Image.imgWidgetDailyEmpty
          }

          Text(isAllDone ? "오늘 해야할 일을 다 끝냈어요!\nNicely done 🎉" : "아직 오늘 해야할 일이 없어요\n새롭게 추가해볼까요?")
            .font(.spoqaHans(size: 14))
            .foregroundColor(Color.textInactive)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .padding(.bottom, 4)
        }
        Spacer()
      }

      Spacer()
    }
    .containerBackground(for: .widget) {
      Color.white
    }
  }
}

// MARK: - Properties

private extension ModaDailyWidgetView {
  var todos: [HomeTodo] {
    let todos = dailyTodosList.first { $0.id == Date.today.format(.dailyId) }?.todos
    return todos?.sorted { $0.order < $1.order } ?? []
  }

  var notDoneTodos: [HomeTodo] {
    Array(todos.filter { !$0.isDone }.prefix(4))
  }

  var doneTodos: [HomeTodo] {
    todos.filter { $0.isDone }
  }

  var isAllDone: Bool {
    guard todos.count > 0 else { return false }
    return todos.allSatisfy { $0.isDone }
  }
}
