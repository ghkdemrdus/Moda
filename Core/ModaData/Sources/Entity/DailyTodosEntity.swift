//
//  DailyTodosEntity.swift
//  moda
//
//  Created by 황득연 on 2022/11/14.
//

import RealmSwift

class DailyTodosEntity: Object {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var date: String = ""
  @Persisted var dailyTodos = List<TodoEntity>()
}

extension DailyTodosEntity {
  func asDomain() -> [Todo] {
    return dailyTodos.map { $0.asDomainToDaily() }
  }
}
