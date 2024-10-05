//
//  ModaWidget.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 2/27/24.
//

import SwiftUI
import WidgetKit
import SwiftData

struct ModaDailyWidget: Widget {
  static let kind: String = "ModaDailyWidget"

  var modelContainer: ModelContainer = {
    let schema = Schema([MonthlyTodos.self, DailyTodos.self, Todo.self])
    let modelConfiguration = ModelConfiguration(schema: schema)

    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: ModaDailyWidget.kind, provider: ModaDailyProvider()) { entry in
      ModaDailyWidgetView(entry: entry)
        .modelContainer(modelContainer)
    }
    .configurationDisplayName("데일리 위젯")
    .description("데일리 투두를 확인해보세요")
    .supportedFamilies([.systemMedium])
  }
}
