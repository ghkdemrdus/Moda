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
    return entry
  }

  func getSnapshot(in context: Context, completion: @escaping (ModaDailyEntry) -> ()) {
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ModaDailyEntry>) -> ()) {
    let timeline = Timeline(entries: [entry], policy: .atEnd)
    completion(timeline)
  }

  private var entry: ModaDailyEntry {
    ModaDailyEntry(date: Date())
  }
}
