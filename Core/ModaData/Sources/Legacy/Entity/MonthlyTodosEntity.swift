//
//  MonthlyTodoInfoEntity.swift
//  moda
//
//  Created by 황득연 on 2022/11/13.
//

import RealmSwift

public class MonthlyTodoInfoEntity: Object {
  @Persisted(primaryKey: true) public var id: ObjectId
  @Persisted public var date: String = ""
  @Persisted public var monthlyTodos = List<TodoEntity>()
}

public extension MonthlyTodoInfoEntity {
  func asDomain() -> [HomeTodo] {
    monthlyTodos.map { $0.asDomainToMonthly() }
  }
}
