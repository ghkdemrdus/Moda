//
//  BookmarkTodoEditItemView.swift
//  Moda
//
//  Created by 황득연 on 10/20/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct BookmarkTodoEditItemView: View {

  static let height: CGFloat = 46

  @Bindable var todo: BookmarkTodo

  let onTapEdit: (BookmarkTodo) -> Void
  let onTapDelete: (BookmarkTodo) -> Void

  var body: some View {
    content
  }
}

// MARK: - Content

private extension BookmarkTodoEditItemView {
  @ViewBuilder var content: some View {
    VStack(spacing: 0) {
      HStack(spacing: 0) {
        TextField("", text: $todo.content)
          .font(.spoqaHans(size: 15))
          .foregroundStyle(Color.textSecondary)
          .frame(maxWidth: .infinity, alignment: .leading)
          .underline()
          .submitLabel(.done)

        Spacer()

        HStack(spacing: 0) {
          PlainButton { onTapEdit(todo) } label: {
            Image.icPencil
              .frame(size: 32)
          }

          PlainButton { onTapDelete(todo) } label: {
            Image.icDailyTrash
              .frame(size: 32)
          }

          Image.icDailyReorder
            .frame(size: 32)
        }
      }
      .padding(.leading, 20)
      .padding(.trailing, 16)
      .frame(height: BookmarkTodoEditItemView.height)
    }
    .background(alignment: .bottom) {
      Color.borderPrimary.frame(height: 1)
        .padding(.horizontal, 20)
    }
  }
}
