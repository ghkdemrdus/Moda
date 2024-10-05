//
//  MonthlyTodosEntity.swift
//  moda
//
//  Created by 황득연 on 2022/11/13.
//

import RealmSwift

public class MonthlyTodosEntity: Object {
  @Persisted(primaryKey: true) public var id: ObjectId
  @Persisted public var date: String = ""
  @Persisted public var monthlyTodos = List<TodoEntity>()
}

public extension MonthlyTodosEntity {
  public func asDomain() -> [Todo] {
    monthlyTodos.map { $0.asDomainToMonthly() }
  }
}
