//
//  HomeTodo.swift
//  Moda
//
//  Created by 황득연 on 9/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftData
import Foundation

@Model
public class HomeTodo: Identifiable, Equatable, Hashable {

  public enum Category: String, Codable {
    case monthly
    case daily
  }

  @Attribute(.unique) public var id: String

  // SwiftData가 Array의 순서를 보장해주지 않기 때문에 추가함.
  public var order: Int
  public var content: String
  public var isDone: Bool
  public var category: Category

  public init(id: String, order: Int, content: String, isDone: Bool, category: Category) {
    self.id = id
    self.order = order
    self.content = content
    self.isDone = isDone
    self.category = category
  }

  public convenience init(content: String, isDone: Bool = false, category: Category) {
    self.init(id: Self.uniqueId, order: -1, content: content, isDone: isDone, category: category)
  }

  public static var uniqueId: String { String(Int(Date().timeIntervalSince1970)) }
}

public extension [HomeTodo] {
  func updating(todo: HomeTodo) -> [HomeTodo] {
    var updatedTodos = self

    let removingIdx = updatedTodos.firstIndex(where: { $0.id == todo.id })
    if let removingIdx {
      updatedTodos.remove(at: removingIdx)
    }

    let updatingIdx = updatedTodos.firstIndex(where: { $0.isDone })
    if let updatingIdx, !todo.isDone {
      updatedTodos.insert(todo, at: updatingIdx)
    } else {
      updatedTodos.append(todo)
    }

    for (idx, updateTodo) in updatedTodos.enumerated() {
      updateTodo.order = idx
    }

    return updatedTodos
  }

  func updating() -> [HomeTodo] {
    var updatedTodos = self

    for (idx, updateTodo) in updatedTodos.enumerated() {
      updateTodo.order = idx
    }

    return updatedTodos
  }
}
