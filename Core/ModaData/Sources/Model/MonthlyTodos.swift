//
//  MonthlyTodos.swift
//  moda
//
//  Created by 황득연 on 2022/11/13.
//

import SwiftData

@Model
public class MonthlyTodos {
  @Attribute(.unique) public  var id: String
  public var todos: [HomeTodo]

  public init(id: String, todos: [HomeTodo]) {
    self.id = id
    self.todos = todos
  }
}
