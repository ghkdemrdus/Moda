//
//  BookmarkTodoEditView.swift
//  Moda
//
//  Created by 황득연 on 10/19/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

@ViewAction(for: BookmarkTodoEditCore.self)
struct BookmarkTodoEditView: View {

  @Bindable var store: StoreOf<BookmarkTodoEditCore>

  @State private var keyboardHeight: CGFloat = 0

  var bottomPadding: CGFloat {
    keyboardHeight.isZero ? 0 : keyboardHeight - 50 - UIApplication.shared.safeAreaBottomHeight
  }

  var body: some View {
    content
      .keyboardHeight($keyboardHeight)
      .onFirstAppear {
        send(.onFirstAppear)
      }
  }
}

private extension BookmarkTodoEditView {
  @ViewBuilder var content: some View {
    VStack(spacing: 0) {
      Spacer().frame(height: 52)

      Text(store.bookmark.title)
        .font(.spoqaHans(size: 15, weight: .bold))
        .foregroundStyle(Color.textPrimary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(
          RoundedRectangle(cornerRadius: 12)
            .fill(Color.backgroundSecondary)
        )
        .padding(.horizontal, 16)

      HStack(spacing: 0) {
        Text("리스트 \(store.bookmark.todos.count)")
          .font(.spoqaHans(size: 12))
          .foregroundStyle(Color.textAlternative)

        Spacer()

        PlainButton {
          send(.doneTapped)
        } label: {
          Text("완료")
            .font(.spoqaHans(size: 14, weight: .bold))
            .foregroundStyle(Color.iconTertiary)
        }
      }
      .frame(height: 24)
      .padding(.top,12)
      .padding(.horizontal, 20)

      DraggableListView(
        items: $store.bookmark.todos,
        itemHeight: BookmarkTodoEditItemView.height,
        itemView: {
          BookmarkTodoEditItemView(
            todo: $0,
            onTapEdit: {
              send(.editTapped($0))
            },
            onTapDelete: {
              hideKeyboard()
              send(.deleteTapped($0))
            }
          )
        }
      )

      Spacer()
      Spacer().frame(height: bottomPadding)
    }
    .background {
      Color.backgroundPrimary.opacity(0.5)
        .ignoresSafeArea()
        .onTapGesture {
          send(.doneTapped)
        }
    }
  }
}
