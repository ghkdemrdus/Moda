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

  @Dependency(\.userData) var userData
  @Dependency(\.versionManager) var versionManager

  public init(store: StoreOf<Splash>) {
    self.store = store
  }

  var body: some View {
    Image.imgSplash
      .ignoresSafeArea()
      .task {
        let version = Bundle.main.version

        async let upgradeTask: () = onUpgrade(version: version)
        async let sleepTask: () = Task.sleep(for: .seconds(1))

        _ = try? await [upgradeTask, sleepTask]
        _ = withAnimation(.easeInOut) {
          send(.timeout)
        }
      }
  }

  func onUpgrade(version: String) async {
    await checkIsUpdated(version: version)
    await migrateTodoDataIfNeeded(version: version)
  }

  func checkIsUpdated(version: String) async {
    await versionManager.checkIsUpdated(version: version)
  }

  func migrateTodoDataIfNeeded(version: String) async {
    let shouldMigrateTodoData = versionManager.shouldMigrateTodoData(version: version)
    guard shouldMigrateTodoData else { return }

    let monthlyTodoEntities = TodoStorage.shared.fetchMonthlyTodos()
    let dailyTodoEntities = TodoStorage.shared.fetchDailyTodos()

    // 1. 월별 투두 변환 작업을 비동기적으로 처리
    let monthlyResults = await withTaskGroup(of: MonthlyTodos.self) { taskGroup -> [MonthlyTodos] in
        for entity in monthlyTodoEntities {
            taskGroup.addTask {
                let todos = entity.monthlyTodos.map {
                    Todo(id: $0.todoId, content: $0.content, isDone: $0.isDone, category: .monthly)
                }
                return MonthlyTodos(id: entity.date, todos: Array(todos))
            }
        }

        var results = [MonthlyTodos]()
        for await result in taskGroup {
            results.append(result)
        }
        return results
    }

    // 2. 일별 투두 변환 작업을 비동기적으로 처리
    let dailyResults = await withTaskGroup(of: DailyTodos.self) { taskGroup -> [DailyTodos] in
        for entity in dailyTodoEntities {
            taskGroup.addTask {
                let todos = entity.dailyTodos.map {
                    Todo(id: $0.todoId, content: $0.content, isDone: $0.isDone, category: .daily)
                }
                return DailyTodos(id: entity.date, todos: Array(todos))
            }
        }

        var results = [DailyTodos]()
        for await result in taskGroup {
            results.append(result)
        }
        return results
    }

    // 3. 변환된 데이터를 MainActor에서 modelContext에 삽입
    await MainActor.run {
      for monthlyTodo in monthlyResults {
        modelContext.insert(monthlyTodo)
      }
      for dailyTodo in dailyResults {
        modelContext.insert(dailyTodo)
      }

      do {
        try modelContext.save()
      } catch {
        print("마이그레이션 실패: \(error)")
      }
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  SplashView(
    store: Store(initialState: Splash.State()) {
      Splash()
    }
  )
}
