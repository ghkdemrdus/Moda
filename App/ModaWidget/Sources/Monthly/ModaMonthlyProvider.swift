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
    return ModaMonthlyEntry(date: Date())
  }

  func getSnapshot(in context: Context, completion: @escaping (ModaMonthlyEntry) -> ()) {
    completion(ModaMonthlyEntry(date: Date()))
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ModaMonthlyEntry>) -> ()) {
    let entry = ModaMonthlyEntry(date: Date.today.addDays(1))
    let timeline = Timeline(entries: [entry], policy: .atEnd)
    completion(timeline)
  }
}
