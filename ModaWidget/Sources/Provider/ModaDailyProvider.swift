//
//  ModaProvider.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 2/27/24.
//

import WidgetKit
import SwiftUI
import Realm

struct ModaDailyProvider: TimelineProvider {

  private let todoStroage = TodoStorage.shared
  private var todos: [Todo] {
    let todos = todoStroage.fetchDailyTodosForWidget(date: Date())
    return Array(todos.filter { !$0.isDone }.prefix(4))
  }
  func placeholder(in context: Context) -> ModaDailyEntry {
    return ModaDailyEntry(date: Date(), dailyTodos: todos)
  }

  func getSnapshot(in context: Context, completion: @escaping (ModaDailyEntry) -> ()) {
    let entry = ModaDailyEntry(date: Date(), dailyTodos: todos)
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ModaDailyEntry>) -> ()) {
    let entry = ModaDailyEntry(date: Date(), dailyTodos: todos)

    let timeline = Timeline(entries: [entry], policy: .never)
    completion(timeline)
  }
}
