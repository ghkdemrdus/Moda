//
//  ModaTodoProvider.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/9/24.
//

import WidgetKit
import SwiftUI

struct ModaTodoProvider: TimelineProvider {
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

  private var entry: ModaTodoEntry {
    ModaTodoEntry(date: Date())
  }
}
