//
//  ModaWidget.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 2/27/24.
//

import SwiftUI
import WidgetKit

struct ModaDailyWidget: Widget {
    static let kind: String = "ModaDailyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: ModaDailyWidget.kind, provider: ModaDailyProvider()) { entry in
          ModaDailyWidgetView(entry: entry)
        }
        .configurationDisplayName("hi")
        .description("bye")
        .supportedFamilies([.systemMedium])
    }
}
