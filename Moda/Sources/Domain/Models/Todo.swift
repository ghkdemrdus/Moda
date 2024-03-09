//
//  Todo.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import Foundation
import RxDataSources

struct Todo: Hashable {
  
  let id: String
  let content: String
  var isDone: Bool
  let type: TodoDataSection.TodoSection
  
  static let `default` = Todo(id: "", content: "", isDone: false, type: .daily)
}

extension Todo {
  func toEntity() -> TodoEntity {
    TodoEntity(todoId: id, content: content, isDone: isDone)
  }
}