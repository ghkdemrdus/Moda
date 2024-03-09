//
//  ModaTodoWidget.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/9/24.
//

import SwiftUI
import WidgetKit

struct ModaTodoWidget: Widget {
  static let kind: String = "ModaTodoWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: ModaTodoWidget.kind, provider: ModaTodoProvider()) { entry in
      ModaTodoWidgetView(entry: entry)
    }
    .configurationDisplayName("hi")
    .description("bye")
    .supportedFamilies([.systemLarge])
  }
}
