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
    return ModaTodoEntry(date: Date(), monthlyTodos: monthlyTodos, dailyTodos: dailyTodos)
  }

  func getSnapshot(in context: Context, completion: @escaping (ModaTodoEntry) -> ()) {
    let entry = ModaTodoEntry(date: Date(), monthlyTodos: monthlyTodos, dailyTodos: dailyTodos)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ModaTodoEntry>) -> ()) {
    let entry = ModaTodoEntry(date: Date(), monthlyTodos: monthlyTodos, dailyTodos: dailyTodos)
    let timeline = Timeline(entries: [entry], policy: .atEnd)
    completion(timeline)
  }
}
