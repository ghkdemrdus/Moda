//
//  ModaMonthlyWidget.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/9/24.
//

import SwiftUI
import WidgetKit

struct ModaMonthlyWidget: Widget {
  static let kind: String = "ModaMonthlyWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: ModaMonthlyWidget.kind, provider: ModaMonthlyProvider()) { entry in
      ModaMonthlyWidgetView(entry: entry)
    }
    .configurationDisplayName("hi")
    .description("bye")
    .supportedFamilies([.systemMedium])
  }
}
