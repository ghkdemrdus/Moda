//
//  DailyTodosEntity.swift
//  moda
//
//  Created by 황득연 on 2022/11/14.
//

import SwiftData

@Model
class DailyTodos {
  @Attribute(.unique) var id: String
  var date: String
  var dailyTodos: [Todo]

  init(id: String, date: String, dailyTodos: [Todo]) {
    self.id = id
    self.date = date
    self.dailyTodos = dailyTodos
  }
}

//extension DailyTodosEntity {
//  func asDomain() -> [Todo] {
//    return dailyTodos.map { $0.asDomainToDaily() }
//  }
//}
