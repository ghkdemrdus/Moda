//
//  BookmarkTodo.swift
//  ModaData
//
//  Created by 황득연 on 10/13/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftData
import Foundation

@Model
public class BookmarkTodo: Identifiable, Equatable, Hashable {

  @Attribute(.unique) public var id: String

  // SwiftData가 Array의 순서를 보장해주지 않기 때문에 추가함.
  public var order: Int
  public var content: String
  public var memo: String
  public var externalLink: String
  public var isDone: Bool
  public var doneDate: Date

  public init(id: String, order: Int, content: String, memo: String, externalLink: String, isDone: Bool, doneDate: Date) {
    self.id = id
    self.order = order
    self.content = content
    self.memo = memo
    self.externalLink = externalLink
    self.isDone = isDone
    self.doneDate = doneDate
  }

  public convenience init(content: String, memo: String = "", externalLink: String = "", isDone: Bool = false) {
    self.init(id: Self.uniqueId, order: -1, content: content, memo: memo, externalLink: externalLink, isDone: isDone, doneDate: Date.today)
  }

  public static var uniqueId: String { String(Int(Date().timeIntervalSince1970)) }
}

// MARK: - Util

public extension BookmarkTodo {
  var hasContent: Bool { !content.isEmpty || !externalLink.isEmpty || !memo.isEmpty }
}

public extension [BookmarkTodo] {
  func updating(todo: BookmarkTodo) -> [BookmarkTodo] {
    var copy = self

    let removingIdx = copy.firstIndex(where: { $0.id == todo.id })
    if let removingIdx {
      copy.remove(at: removingIdx)
    }

    if !todo.hasContent { return copy }

    let updatingIdx = copy.firstIndex(where: \.isDone)
    if let updatingIdx, !todo.isDone {
      copy.insert(todo, at: updatingIdx)
    } else {
      copy.append(todo)
    }

    for (idx, updateTodo) in copy.enumerated() {
      updateTodo.order = idx
    }

    return copy
  }
}

// MARK: - Mock

public extension [BookmarkTodo] {
  static let travelMock: Self = [.normalMock1, .linkMock1, .memoMock1]
  static let gameMock: Self = [.normalMock2, .linkMock2, .memoMock2]
}

public extension BookmarkTodo {
  static let normalMock1: BookmarkTodo = .init(id: "0", order: 0, content: "상세 컨텐츠 기획", memo: "", externalLink: "", isDone: false, doneDate: .today)
  static let linkMock1: BookmarkTodo = .init(id: "1", order: 1, content: "숙소 예약하기", memo: "", externalLink: "https://www.naver.com", isDone: false, doneDate: .today)
  static let memoMock1: BookmarkTodo = .init(id: "2", order: 2, content: "디즈니씨 티켓 구매하기", memo: "디즈니씨 티켓 160,100원에 완료 ✅", externalLink: "", isDone: false, doneDate: .today)

  static let normalMock2: BookmarkTodo = .init(id: "00", order: 0, content: "라스트 오브 어스 Part1", memo: "", externalLink: "", isDone: false, doneDate: .today)
  static let linkMock2: BookmarkTodo = .init(id: "01", order: 1, content: "워킹 데드", memo: "직접 플레이 하지는 않았고 영상으로 챙겨봄\n그래서 더 재미있었음", externalLink: "https://www.google.co.kr", isDone: false, doneDate: .today)
  static let memoMock2: BookmarkTodo = .init(id: "02", order: 2, content: "할로우 나이트", memo: "", externalLink: "https://www.naver.com", isDone: false, doneDate: .today)
}
