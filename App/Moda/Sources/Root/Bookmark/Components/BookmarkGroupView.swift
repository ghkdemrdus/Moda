//
//  BookmarkGroupView.swift
//  Moda
//
//  Created by 황득연 on 10/13/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct BookmarkGroupView: View {

  let bookmark: Bookmark

  var isAllDone: Bool { bookmark.todos.allSatisfy(\.isDone) }
  var totalCount: Int { bookmark.todos.count }
  var doneCount: Int { bookmark.todos.filter(\.isDone).count }

  var body: some View {
    content
  }
}

// MARK: - Content

private extension BookmarkGroupView {
  @ViewBuilder var content: some View {
    VStack(spacing: 4) {
      HStack(spacing: 8) {
        Text(bookmark.title)
          .font(.spoqaHans(size: 15, weight: .bold))
          .foregroundStyle(Color.textPrimary)

        Spacer()

        if isAllDone {
          HStack(spacing: 2) {
            Image.icCheck
              .resizable()
              .frame(size: 12)

            Text("완료")
              .font(.spoqaHans(size: 11))
              .foregroundStyle(Color.white)
          }
          .padding(.vertical, 5)
          .padding(.horizontal, 8)
          .background(
            Capsule()
              .fill(Color.orange300)
          )
        } else if totalCount > 0 {
          Text("\(doneCount)/\(totalCount)")
            .font(.spoqaHans(size: 11))
            .foregroundStyle(Color.textTertiary)
            .padding(.vertical, 5)
            .padding(.horizontal, 8)
            .background(
              Capsule()
                .fill(Color.backgroundPrimary)
                .stroke(Color.borderPrimary, lineWidth: 1)
            )
        }

        PlainButton {
          bookmark.isFolded.toggle()
        } label: {
          Image.icArrow
            .rotationEffect(bookmark.isFolded ? .radians(.pi / 2) : .radians(.pi * 3 / 2))
        }
      }
      .padding(.vertical, 14)
      .padding(.horizontal, 16)
      .background(
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.backgroundSecondary)
      )
      .padding(.horizontal, 16)

      if !bookmark.isFolded {
        VStack(spacing: 2) {
          HStack(spacing: 0) {
            Text("리스트 \(totalCount)")
              .font(.spoqaHans(size: 12))
              .foregroundStyle(Color.textAlternative)

            Spacer()

            HStack(spacing: 2) {
              PlainButton {
              } label: {
                Image.icBookmarkEdit
                  .frame(size: 28)
              }

              PlainButton {
              } label: {
                Image.icBookmarkAdd
                  .frame(size: 28)
              }
            }
          }
          .padding(.leading, 20)
          .padding(.trailing, 16)

          VStack(spacing: 6) {
            ForEach(bookmark.todos) { todo in
              BookmarkItemView(todo: todo)
            }
          }
        }
        .padding(.bottom, 4)
      }
    }
  }
}

// MARK: - Preview

#Preview {
  BookmarkGroupView(
    bookmark: .init(
      title: "✈️ 도쿄 여행 계획 짜기",
      todos: .mock
    )
  )
}
