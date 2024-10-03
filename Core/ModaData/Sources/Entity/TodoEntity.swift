//
//  Model.swift
//  ModaData
//
//  Created by 황득연 on 10/3/24.
//

import SwiftData

@Model
public class TodoEntity {
  @Attribute(.unique) var id: String
  var content: String
  var isDone: Bool

  public init(id: String, content: String, isDone: Bool) {
    self.id = id
    self.content = content
    self.isDone = isDone
  }
}

public extension TodoEntity {
  func asDomainToMonthly() -> Todo {
    Todo(
      id: id,
      content: content,
      isDone: isDone,
      type: .monthly
    )
  }

  func asDomainToDaily() -> Todo {
    Todo(
      id: id,
      content: content,
      isDone: isDone,
      type: .daily
    )
  }
}
