//
//  Model.swift
//  ModaData
//
//  Created by 황득연 on 10/3/24.
//

import RealmSwift

public class TodoEntity: Object {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted public var todoId: String
  @Persisted public var content: String
  @Persisted public var isDone: Bool

  public convenience init(todoId: String, content: String, isDone: Bool) {
    self.init()

    self.todoId = todoId
    self.content = content
    self.isDone = isDone
  }
}

public extension TodoEntity {
  func asDomainToMonthly() -> HomeTodo {
    HomeTodo(
      content: content,
      category: .monthly
    )
  }

  func asDomainToDaily() -> HomeTodo {
    HomeTodo(
      content: content,
      category: .daily
    )
  }
}
