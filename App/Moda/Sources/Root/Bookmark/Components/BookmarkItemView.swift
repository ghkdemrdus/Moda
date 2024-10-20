//
//  BookmarkItemView.swift
//  Moda
//
//  Created by 황득연 on 10/13/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct BookmarkItemView: View {

  let todo: BookmarkTodo

  let onTapDone: (BookmarkTodo) -> Void

  var body: some View {
    content
  }
}

// MARK: - Content

private extension BookmarkItemView {
  @ViewBuilder var content: some View {
    VStack(spacing: 0) {
      HStack(alignment: .top, spacing: 8) {
        PlainButton {
          onTapDone(todo)
        } label: {
          todo.isDone
          ? Image.imgCheckActive
            .frame(size: 36)
          : Image.imgCheckDailyInactive
            .frame(size: 36)
        }

        Text(todo.content)
          .font(.spoqaHans(size: 15))
          .foregroundStyle(Color.textSecondary)
          .lineLimit(nil)
          .strikethrough(todo.isDone)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.top, 8.5)
          .padding(.bottom, 12.5)

        Spacer()

        HStack(spacing: 2) {
          if todo.isDone {
            Text(todo.doneDate.format(.bookmarkDate))
              .font(.spoqaHans(size: 13))
              .foregroundStyle(Color.textCaption)
          }

          if !todo.externalLink.isEmpty, let url = URL(string: todo.externalLink) {
            PlainButton {
              UIApplication.shared.open(url)
            } label: {
              Image.icLink
                .frame(size: 36)
            }
          }
        }
        .frame(height: 36)
      }
      .padding(.leading, 14)
      .padding(.trailing, todo.externalLink.isEmpty ? 20 : 16)

      if !todo.memo.isEmpty {
        Text(todo.memo)
          .font(.spoqaHans(size: 13, weight: .regular))
          .foregroundStyle(Color.textSecondary)
          .frame(maxWidth: .infinity, alignment: .leading)
          .lineLimit(nil)
          .padding(12)
          .background(
            RoundedRectangle(cornerRadius: 8)
              .fill(Color.backgroundTertiary)
              .stroke(Color.borderPrimary, lineWidth: 1)
          )
          .padding(.horizontal, 20)
          .padding(.bottom, 10)
      }
    }
    .background(alignment: .bottom) {
      Color.borderPrimary.frame(height: 1)
        .padding(.horizontal, 20)
    }
  }
}

// MARK: - Preview

#Preview("일반 투두") {
  @Previewable @State var todo: BookmarkTodo = .normalMock1

  BookmarkItemView(todo: todo, onTapDone: { $0.isDone.toggle() })
}

#Preview("메모가 있는 투두") {
  @Previewable @State var todo: BookmarkTodo = .memoMock1

  BookmarkItemView(todo: todo, onTapDone: { $0.isDone.toggle() })
}

#Preview("외부 링크가 있는 투두") {
  @Previewable @State var todo: BookmarkTodo = .linkMock1

  BookmarkItemView(todo: todo, onTapDone: { $0.isDone.toggle() })
}
