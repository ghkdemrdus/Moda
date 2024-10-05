//
//  ModaMonthlyWidget.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/9/24.
//

import SwiftUI
import WidgetKit
import SwiftData

struct ModaMonthlyWidget: Widget {
  static let kind: String = "ModaMonthlyWidget"

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
    StaticConfiguration(kind: ModaMonthlyWidget.kind, provider: ModaMonthlyProvider()) { entry in
      ModaMonthlyWidgetView(entry: entry)
        .modelContainer(modelContainer)
    }
    .configurationDisplayName("먼쓸리 위젯")
    .description("먼쓸리 투두를 확인해보세요")
    .supportedFamilies([.systemMedium])
  }
}
