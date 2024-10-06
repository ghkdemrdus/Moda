//
//  ModaProvider.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 2/27/24.
//

import WidgetKit
import SwiftUI
import SwiftData

struct ModaDailyProvider: TimelineProvider {
  func placeholder(in context: Context) -> ModaDailyEntry {
    return ModaDailyEntry(date: Date())
  }

  func getSnapshot(in context: Context, completion: @escaping (ModaDailyEntry) -> ()) {
    completion(ModaDailyEntry(date: Date()))
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ModaDailyEntry>) -> ()) {
    let entry = ModaDailyEntry(date: Date.today.addDays(1))
    let timeline = Timeline(entries: [entry], policy: .atEnd)
    completion(timeline)
  }
}
