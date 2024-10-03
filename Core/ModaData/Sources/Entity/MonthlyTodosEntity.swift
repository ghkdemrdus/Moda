//
//  MonthlyTodosEntity.swift
//  moda
//
//  Created by 황득연 on 2022/11/13.
//

import SwiftData

@Model
class MonthlyTodosEntity {
  @Attribute(.unique) var id: String
  var date: String
  var monthlyTodos: [TodoEntity]

  init(
    id: String,
    date: String,
    monthlyTodos: [TodoEntity]
  ) {
    self.id = id
    self.date = date
    self.monthlyTodos = monthlyTodos
  }
}

//extension MonthlyTodosEntity {
//  func asDomain() -> [Todo] {
//    return monthlyTodos.map { $0.asDomainToMonthly() }
//  }
//}

