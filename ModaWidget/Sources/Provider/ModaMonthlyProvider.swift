//
//  ModaMonthlyProvider.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/9/24.
//

import WidgetKit
import SwiftUI
import Realm

struct ModaMonthlyProvider: TimelineProvider {

  private let todoStroage = TodoStorage.shared
  private var todos: [Todo] {
    let todos = todoStroage.fetchMonthlyTodosForWidget(date: Date())
    return Array(todos.filter { !$0.isDone }.prefix(4))
  }
  func placeholder(in context: Context) -> ModaMonthlyEntry {
    return ModaMonthlyEntry(date: Date(), monthlyTodos: todos)
  }

  func getSnapshot(in context: Context, completion: @escaping (ModaMonthlyEntry) -> ()) {
    let entry = ModaMonthlyEntry(date: Date(), monthlyTodos: todos)
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ModaMonthlyEntry>) -> ()) {
    let entry = ModaMonthlyEntry(date: Date(), monthlyTodos: todos)

    let timeline = Timeline(entries: [entry], policy: .atEnd)
    completion(timeline)
  }
}
