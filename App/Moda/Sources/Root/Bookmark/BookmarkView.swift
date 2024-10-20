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

  @State private var focusedOnAddItem: Bool = false
  @State private var keyboardHeight: CGFloat = 0

  var inputBottomPadding: CGFloat {
    keyboardHeight.isZero ? 0 : keyboardHeight - 50 - UIApplication.shared.safeAreaBottomHeight
  }

  var body: some View {
    content
      .keyboardHeight($keyboardHeight)
      .onChange(of: store.addedTodo) {
        focusedOnAddItem = $1 != nil
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
      BookmarkHeaderView(
        bookmarkCount: store.bookmarks.count,
        onTapEdit: {
          send(.binding(.set(\.isEditPresented, true)))
        }
      )
      .opacity(store.isEditPresented ? 0 : 1)

      if store.bookmarks.isEmpty {
        BookmarkEmptyView()
          .opacity(store.isEditPresented ? 0 : 1)
      } else {
        BookmarkListView(
          bookmarks: store.bookmarks,
          addedBookmark: $store.addedBookmark,
          addedTodo: $store.addedTodo,
          focusedOnAddItem: $focusedOnAddItem,
          onTapTodoDone: {
            send(.todoTapped($0, $1))
          },
          onTapAddTodo: {
            send(.todoAddTapped($0))
          },
          onAddTodo: {
            send(.todoAdded($0, $1))
          }
        )
        .opacity(store.isEditPresented ? 0 : 1)
      }

      if let todo = store.addedTodo {
        BookmarkInputView(
          todo: todo,
          onAddTodo: {
            if let bookmark = store.addedBookmark {
              send(.todoAdded(bookmark, $0))
            }
          },
          onLoseFocus: {
            focusedOnAddItem = true
          }
        )
        .padding(.bottom, inputBottomPadding)
        .opacity(store.isEditPresented ? 0 : 1)
      }
    }
    .background(Color.backgroundPrimary)
    .blur(radius: store.isEditPresented ? 1.2 : 0)
    .overlay(if: store.isEditPresented) {
      BookmarkEditView(store: store.scope(state: \.edit, action: \.edit))
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
