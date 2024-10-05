//
//  ModaMonthlyProvider.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/9/24.
//

import WidgetKit
import SwiftUI
import SwiftData

struct ModaMonthlyProvider: TimelineProvider {
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

  private var entry: ModaMonthlyEntry {
    ModaMonthlyEntry(date: Date())
  }
}
