//
//  BookmarkListView.swift
//  Moda
//
//  Created by 황득연 on 10/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct BookmarkListView: View {

  let bookmarks: [Bookmark]

  @Binding var addedBookmark: Bookmark?
  @Binding var addedTodo: BookmarkTodo?
  @Binding var focusedOnAddItem: Bool

  let onTapEdit: (Bookmark) -> Void
  let onTapTodoDone: (Bookmark, BookmarkTodo) -> Void
  let onTapAddTodo: (Bookmark) -> Void
  let onAddTodo: (Bookmark, BookmarkTodo) -> Void

  var body: some View {
    ScrollViewReader { proxy in
      ScrollView {
        VStack(spacing: 8) {
          ForEach(bookmarks) { bookmark in
            BookmarkGroupView(
              bookmark: bookmark,
              addedBookmark: $addedBookmark,
              addedTodo: $addedTodo,
              focusedOnAddItem: $focusedOnAddItem,
              scrollProxy: proxy,
              onTapEdit: onTapEdit,
              onTapTodoDone: onTapTodoDone,
              onTapAddTodo: onTapAddTodo,
              onAddTodo: onAddTodo
            )
          }
        }
        .padding(.top, 4)
        .padding(.bottom, 8)
      }
    }
  }
}

