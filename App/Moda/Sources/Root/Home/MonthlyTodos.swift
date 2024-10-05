//
//  MonthlyTodosEntity.swift
//  moda
//
//  Created by 황득연 on 2022/11/13.
//

import SwiftData

@Model
class MonthlyTodos {
  @Attribute(.unique) var id: String
  @Relationship var todos: [Todo]

  init(id: String, todos: [Todo]) {
    self.id = id
    self.todos = todos
  }
}

//extension MonthlyTodosEntity {
//  func asDomain() -> [Todo] {
//    return monthlyTodos.map { $0.asDomainToMonthly() }
//  }
//}

