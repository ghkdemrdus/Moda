//
//  ModaTodoEntry.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/9/24.
//

import WidgetKit

struct ModaTodoEntry: TimelineEntry {
  var date: Date
  let monthlyTotalCount: Int
  let monthlyDoneCount: Int
  let dailyTotalCount: Int
  let dailyDoneCount: Int
  let monthlyTodos: [Todo]
  let dailyTodos: [Todo]
}
