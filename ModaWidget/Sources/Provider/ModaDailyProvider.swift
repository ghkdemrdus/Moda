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

  // MARK: - Properties

  private let todoStroage = TodoStorage.shared
  private var entry: ModaDailyEntry {
    let todos = todoStroage.fetchDailyTodosForWidget(date: Date())
    return ModaDailyEntry(
      date: Date(),
      totalCount: todos.count,
      doneCount: todos.filter { $0.isDone }.count,
      dailyTodos:  Array(todos.filter { !$0.isDone }.prefix(4))
    )
  }

  // MARK: - Methods

  func placeholder(in context: Context) -> ModaDailyEntry {
    return entry
  }

  func getSnapshot(in context: Context, completion: @escaping (ModaDailyEntry) -> ()) {
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ModaDailyEntry>) -> ()) {
    let timeline = Timeline(entries: [entry], policy: .never)
    completion(timeline)
  }
}
