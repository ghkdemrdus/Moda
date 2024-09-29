//
//  Todo.swift
//  Moda
//
//  Created by 황득연 on 9/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

public struct Todo: Identifiable, Equatable {

  public enum `Type` {
    case monthly
    case daily
  }

  public let id: String
  public var content: String
  public var isDone: Bool
  public let type: `Type`

  public init(id: String, content: String, isDone: Bool, type: `Type`) {
    self.id = id
    self.content = content
    self.isDone = isDone
    self.type = type
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }
}
