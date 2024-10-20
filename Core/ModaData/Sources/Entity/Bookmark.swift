//
//  Bookmark.swift
//  ModaData
//
//  Created by 황득연 on 10/13/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftData
import Foundation

@Model
public class Bookmark: Identifiable, Equatable, Hashable {

  @Attribute(.unique) public var id: String

  // SwiftData가 Array의 순서를 보장해주지 않기 때문에 추가함.
  public var order: Int
  public var title: String
  public var isFolded: Bool
  public var todos: [BookmarkTodo]

  public init(id: String, order: Int, title: String, isFolded: Bool, todos: [BookmarkTodo]) {
    self.id = id
    self.order = order
    self.title = title
    self.isFolded = isFolded
    self.todos = todos
  }

  public init(title: String, isFolded: Bool = false, todos: [BookmarkTodo] = []) {
    self.id = Self.uniqueId
    self.order = -1
    self.title = title
    self.isFolded = isFolded
    self.todos = todos
  }

  public static var uniqueId: String { String(Int(Date().timeIntervalSince1970)) }
}

// MARK: - Updating

public extension [Bookmark] {
  /// 북마크 수정 완료 시에 타이틀이 있거나 내용물이 있는 경우가 아닌 경우는 제거한다.
  func updating() -> Self {
    var copy = self
    copy = copy.filter { !$0.title.isEmpty || !$0.todos.isEmpty }
    return copy.reordering()
  }

  func reordering() -> Self {
    let copy = self
    for (idx, bookmark) in copy.enumerated() {
      bookmark.order = idx
    }
    return copy
  }
}

// MARK: - Mock

public extension Bookmark {
  static let travelMock: Bookmark = .init(id: "0", order: 0, title: "✈️ 도쿄 여행 계획 짜기", isFolded: false, todos: .travelMock)
  static let gameMock: Bookmark = .init(id: "1", order: 1, title: "🎮 게임 리스트", isFolded: false, todos: .gameMock)
}
