//
//  BookmarkView.swift
//  Moda
//
//  Created by 황득연 on 10/13/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SwiftData

@ViewAction(for: BookmarkCore.self)
struct BookmarkView: View {

  @Bindable var store: StoreOf<BookmarkCore>

  @Environment(\.modelContext) var modelContext
  @Query var bookmarks: [Bookmark]

  var body: some View {
    content
      .onChange(of: store.currentDate, initial: true) {
        changeBookmark(date: $1)
      }
  }

  private func changeBookmark(date: Date) {
    let id = date.format(.bookmarkId)
    let bookmarks = bookmarks.filter { $0.id == id }
    send(.updateBookmarks(bookmarks))
  }
}

// MARK: - Content

private extension BookmarkView {
  @ViewBuilder var content: some View {
    VStack(spacing: 0) {
      BookmarkTitleView(currentDate: $store.currentDate)
      BookmarkHeaderView(bookmarkCount: store.bookmarks.count)
        .padding(.top, 4)

      ScrollView {
        LazyVStack(spacing: 8) {
          ForEach(store.bookmarks) { bookmark in
            BookmarkGroupView(bookmark: bookmark)
          }
        }
        .padding(.vertical, 8)
      }
    }
  }
}

// MARK: - Preview

#Preview {
  BookmarkView(
    store: .init(initialState: BookmarkCore.State()) {
      BookmarkCore()
    }
  )
}
