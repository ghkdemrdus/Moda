//
//  DailyTodos.swift
//  moda
//
//  Created by 황득연 on 2022/11/14.
//

import SwiftData

@Model
public class DailyTodos {
  @Attribute(.unique) public var id: String
  @Relationship public var todos: [Todo]

  public init(id: String, todos: [Todo]) {
    self.id = id
    self.todos = todos
  }
}

