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
    ModaTodoEntry(date: Date())
  }

  func getSnapshot(in context: Context, completion: @escaping (ModaTodoEntry) -> ()) {
    completion(ModaTodoEntry(date: Date()))
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<ModaTodoEntry>) -> ()) {
    let entry = ModaTodoEntry(date: Date())
    let timeline = Timeline(entries: [entry], policy: .atEnd)
    completion(timeline)
  }
}
