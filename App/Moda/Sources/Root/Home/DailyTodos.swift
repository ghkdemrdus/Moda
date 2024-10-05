//
//  DailyTodos.swift
//  moda
//
//  Created by 황득연 on 2022/11/14.
//

import SwiftData

@Model
class DailyTodos {
  @Attribute(.unique) var id: String
  @Relationship var todos: [Todo]

  init(id: String, todos: [Todo]) {
    self.id = id
    self.todos = todos
  }
}

