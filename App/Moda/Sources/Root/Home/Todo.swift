//
//  Todo.swift
//  Moda
//
//  Created by 황득연 on 9/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftData
import Foundation

@Model
public class Todo: Identifiable, Equatable, Hashable {

  public enum Category: String, Codable {
    case monthly
    case daily
  }

  @Attribute(.unique) public var id: String
  public var content: String
  public var isDone: Bool
  public var category: Category

  public init(id: String, content: String, isDone: Bool, category: Category) {
    self.id = id
    self.content = content
    self.isDone = isDone
    self.category = category
  }

  public convenience init(content: String, category: Category) {
    self.init(id: Self.uniqueId, content: content, isDone: false, category: category)
  }

  static var uniqueId: String { String(Int(Date().timeIntervalSince1970)) }
}
