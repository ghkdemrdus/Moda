//
//  ModaTodoWidget.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/9/24.
//

import SwiftUI
import WidgetKit
import SwiftData

struct ModaTodoWidget: Widget {
  static let kind: String = "ModaTodoWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: ModaTodoWidget.kind, provider: ModaTodoProvider()) { entry in
      ModaTodoWidgetView(entry: entry)
        .modelContainer(todoModelContainer)
    }
    .configurationDisplayName("먼쓸리 & 데일리 위젯")
    .description("먼쓸리 & 데일리 투두를 확인해보세요!")
    .supportedFamilies([.systemLarge])
  }
}

#Preview(as: .systemMedium) {
  ModaTodoWidget()
} timeline: {
  ModaTodoEntry(date: Date())
}
