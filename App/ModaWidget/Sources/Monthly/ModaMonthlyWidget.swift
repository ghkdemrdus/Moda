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

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: ModaMonthlyWidget.kind, provider: ModaMonthlyProvider()) { entry in
      ModaMonthlyWidgetView(entry: entry)
        .modelContainer(todoModelContainer)
    }
    .configurationDisplayName("먼쓸리 위젯")
    .description("먼쓸리 투두를 확인해보세요!")
    .supportedFamilies([.systemMedium])
  }
}

// MARK: - Preview

#Preview(as: .systemMedium) {
  ModaMonthlyWidget()
} timeline: {
  ModaMonthlyEntry(date: Date())
}
