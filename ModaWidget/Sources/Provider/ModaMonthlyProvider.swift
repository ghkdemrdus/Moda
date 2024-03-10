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
  private var entry: ModaMonthlyEntry {
    let todos = todoStroage.fetchMonthlyTodosForWidget(date: Date())
    return ModaMonthlyEntry(
      date: Date(),
      totalCount: todos.count,
      doneCount: todos.filter { $0.isDone }.count,
      monthlyTodos: Array(todos.filter { !$0.isDone }.prefix(4))
    )
  }

  func placeholder(in context: Context) -> ModaMonthlyEntry {
    return entry
  }

  func getSnapshot(in context: Context, completion: @escaping (ModaMonthlyEntry) -> ()) {
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ModaMonthlyEntry>) -> ()) {
    let timeline = Timeline(entries: [entry], policy: .atEnd)
    completion(timeline)
  }
}
