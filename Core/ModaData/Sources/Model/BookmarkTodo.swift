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

// MARK: - Mock

public extension [BookmarkTodo] {
  static let mock: Self = [.normalMock, .linkMock, .memoMock]
}

public extension BookmarkTodo {
  static let normalMock: BookmarkTodo = .init(id: "0", order: 0, content: "상세 컨텐츠 기획", memo: "", externalLink: "", isDone: false, doneDate: .today)
  static let linkMock: BookmarkTodo = .init(id: "1", order: 1, content: "숙소 예약하기", memo: "", externalLink: "https://www.naver.com", isDone: false, doneDate: .today)
  static let memoMock: BookmarkTodo = .init(id: "2", order: 2, content: "디즈니씨 티켓 구매하기", memo: "디즈니씨 티켓 160,100원에 완료 ✅", externalLink: "", isDone: false, doneDate: .today)
}
