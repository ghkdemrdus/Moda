//
//  Todo.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import Foundation

public struct Todo: Identifiable, Equatable {

  public enum TodoType {
    case monthly
    case daily
  }

  public let id: String
  public var content: String
  public var isDone: Bool
  public let type: TodoType

  public init(id: String, content: String, isDone: Bool, type: TodoType) {
    self.id = id
    self.content = content
    self.isDone = isDone
    self.type = type
  }
}

public extension Todo {
  func toEntity() -> TodoEntity {
    TodoEntity(id: id, content: content, isDone: isDone)
  }
}

public extension Todo {
  static let inactiveDummy = Todo(id: "id", content: "다이어리 작성하기", isDone: false, type: .monthly)
  static let activeDummy = Todo(id: "id", content: "다이어리 작성하기", isDone: true, type: .monthly)
  static let dummy: [Todo] = [
    Todo(id: "id1", content: "다이어리 작성하기", isDone: false, type: .monthly),
    Todo(id: "id2", content: "운동하기", isDone: true, type: .monthly),
  ]
}
