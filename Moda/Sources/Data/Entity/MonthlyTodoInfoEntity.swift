//
//  MonthlyTodoInfoEntity.swift
//  moda
//
//  Created by 황득연 on 2022/11/13.
//

import RealmSwift
import Realm

class MonthlyTodoInfoEntity: Object {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var date: String = ""
  @Persisted var monthlyTodos = List<TodoEntity>()
}

extension MonthlyTodoInfoEntity {
  func asDomain() -> [Todo] {
    return monthlyTodos.map { $0.asDomainToMonthly() }
  }
}

