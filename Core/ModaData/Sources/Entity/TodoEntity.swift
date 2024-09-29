//
//  TodoEntity.swift
//  moda
//
//  Created by 황득연 on 2022/11/14.
//

import RealmSwift

public class TodoEntity: Object {
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var todoId: String
  @Persisted var content: String
  @Persisted var isDone: Bool
  
  convenience init(todoId: String, content: String, isDone: Bool) {
    self.init()
    
    self.todoId = todoId
    self.content = content
    self.isDone = isDone
  }
}

public extension TodoEntity {
  func asDomainToMonthly() -> Todo {
    return Todo(
      id: todoId,
      content: content,
      isDone: isDone,
      type: .monthly
    )
  }
  
  func asDomainToDaily() -> Todo {
    return Todo(
      id: todoId,
      content: content,
      isDone: isDone,
      type: .daily
    )
  }
}

