//
//  ModaDailyEntry.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/9/24.
//

import WidgetKit

struct ModaDailyEntry: TimelineEntry {
  var date: Date
  let totalCount: Int
  let doneCount: Int
  let dailyTodos: [Todo]
}
