//
//  SplashView.swift
//  ModaData
//
//  Created by 황득연 on 3/18/24.
//

import SwiftUI
import ComposableArchitecture
import SwiftData

@ViewAction(for: Splash.self)
struct SplashView: View {

  @Bindable var store: StoreOf<Splash>

  @Environment(\.modelContext) var modelContext
  @Query var monthlyTodosList: [MonthlyTodos]
  @Query var dailyTodosList: [DailyTodos]

  public init(store: StoreOf<Splash>) {
    self.store = store
  }

  var body: some View {
    content
      .task {
        send(.onTask)
      }
      .onChange(of: store.shouldMigrateTodos, initial: true) {
        guard let shouldMigrate = $1 else { return }
        if shouldMigrate {
          migrateTodoData()
        }
        send(.migrationFinished)
      }
      .onChange(of: [store.isTimeout, store.isMigrationFinished]) {
        if $1.allSatisfy ({ $0 }) {
          _ = withAnimation(.easeInOut) {
            send(.splashFinished)
          }
        }
      }
  }
}

// MARK: - Content

private extension SplashView {
  var content: some View {
    ZStack {
      Image.imgSplash
    }
    .ignoresSafeArea()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.backgroundPrimary)
  }
}

// MARK: - Methods

private extension SplashView {
  func migrateTodoData() {
    let monthlyTodoEntities = TodoStorage.shared.fetchMonthlyTodos()
    let dailyTodoEntities = TodoStorage.shared.fetchDailyTodos()

    // 1. 먼쓸리 투두 변환 작업
    let monthlyTodosList = monthlyTodoEntities.map { entity in
      let todos = entity.monthlyTodos.enumerated().map { idx, todo in
        HomeTodo(id: todo.todoId, order: idx, content: todo.content, isDone: todo.isDone, category: .monthly)
      }
      return MonthlyTodos(id: entity.date, todos: todos)
    }

    // 2. 데일리 투두 변환 작업
    let dailyTodosList = dailyTodoEntities.map { entity in
      let todos = entity.dailyTodos.enumerated().map { idx, todo in
        HomeTodo(id: todo.todoId, order: idx, content: todo.content, isDone: todo.isDone, category: .daily)
      }
      return DailyTodos(id: entity.date, todos: todos)
    }

    // 3. 변환된 데이터를 modelContext에 삽입
    for monthlyTodos in monthlyTodosList {
      modelContext.insert(monthlyTodos)
    }
    for dailyTodos in dailyTodosList {
      modelContext.insert(dailyTodos)
    }

    do {
      try modelContext.save()
    } catch {
      fatalError("Failed to save: \(error)")
    }
  }
}

// MARK: - Preview

#Preview {
  SplashView(
    store: Store(initialState: Splash.State()) {
      Splash()
    }
  )
}
