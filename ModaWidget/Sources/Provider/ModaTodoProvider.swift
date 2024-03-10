//
//  ModaTodoProvider.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/9/24.
//

import WidgetKit
import SwiftUI
import Realm

struct ModaTodoProvider: TimelineProvider {

  private let todoStroage = TodoStorage.shared
  private var entry: ModaTodoEntry {
    let monthlyTodos = todoStroage.fetchMonthlyTodosForWidget(date: Date())
    let dailyTodos = todoStroage.fetchDailyTodosForWidget(date: Date())
    let monthlyTodosNotDone = monthlyTodos.filter { !$0.isDone }
    let dailyTodosNotDone = dailyTodos.filter { !$0.isDone }

    let prefixOfMonthlyTodos = prefixOfMonthlyTodos(monthlyCount: monthlyTodosNotDone.count, dailyCount: dailyTodosNotDone.count)
    let prefixOfDailyTodos = prefixOfMonthlyTodos == 0 ? 8 : 7 - prefixOfMonthlyTodos

    return ModaTodoEntry(
      date: Date(),
      monthlyTotalCount: monthlyTodos.count,
      monthlyDoneCount: monthlyTodos.filter { $0.isDone }.count,
      dailyTotalCount: dailyTodos.count,
      dailyDoneCount: dailyTodos.filter { $0.isDone }.count,
      monthlyTodos: Array(monthlyTodosNotDone.filter { !$0.isDone }.prefix(prefixOfMonthlyTodos)),
      dailyTodos: Array(dailyTodosNotDone.filter { !$0.isDone }.prefix(prefixOfDailyTodos))
    )
  }

  private func prefixOfMonthlyTodos(monthlyCount: Int, dailyCount: Int) -> Int {
    if monthlyCount + dailyCount <= 7 {
      return monthlyCount
    }

    if dailyCount == 0 {
      return 8
    }

    if monthlyCount >= 3 {
      return max(3, 7 - dailyCount)
    }

    return monthlyCount
  }

  private var monthlyTodos: [Todo] {
    let todos = todoStroage.fetchMonthlyTodosForWidget(date: Date())
    return Array(todos.filter { !$0.isDone }.prefix(3))
  }
  private var dailyTodos: [Todo] {
    let todos = todoStroage.fetchDailyTodosForWidget(date: Date())
    let todoCount: Int
    if monthlyTodos.count == 0 { todoCount = 8 }
    else { todoCount = 7 - monthlyTodos.count }
    return Array(todos.filter { !$0.isDone }.prefix(todoCount))
  }
  
  func placeholder(in context: Context) -> ModaTodoEntry {
    return entry
  }

  func getSnapshot(in context: Context, completion: @escaping (ModaTodoEntry) -> ()) {
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ModaTodoEntry>) -> ()) {
    let timeline = Timeline(entries: [entry], policy: .atEnd)
    completion(timeline)
  }
}
