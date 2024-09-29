//
//  MonthlyTodosEntity.swift
//  moda
//
//  Created by 황득연 on 2022/11/13.
//

import RealmSwift

class MonthlyTodosEntity: Object {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var date: String = ""
  @Persisted var monthlyTodos = List<TodoEntity>()
}

extension MonthlyTodosEntity {
  func asDomain() -> [Todo] {
    return monthlyTodos.map { $0.asDomainToMonthly() }
  }
}

