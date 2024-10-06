//
//  DailyTodoInfoEntity.swift
//  moda
//
//  Created by 황득연 on 2022/11/14.
//

import RealmSwift

public class DailyTodoInfoEntity: Object {
  @Persisted(primaryKey: true) public var id: ObjectId
  @Persisted public var date: String = ""
  @Persisted public var dailyTodos = List<TodoEntity>()
}

public extension DailyTodoInfoEntity {
  func asDomain() -> [HomeTodo] {
    return dailyTodos.map { $0.asDomainToDaily() }
  }
}
