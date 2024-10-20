//
//  BookmarkAddItemView.swift
//  Moda
//
//  Created by 황득연 on 10/19/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct BookmarkAddItemView: View {

  @Bindable var todo: BookmarkTodo

  let onAddTodo: (BookmarkTodo) -> Void

  var body: some View {
    content
//      .onChange(of: focused) {
//        if $0 && !$1 {
//          onFinishAdding(todo)
//        }
//      }
  }
}

// MARK: - Content

private extension BookmarkAddItemView {
  @ViewBuilder var content: some View {
    VStack(spacing: 0) {
      HStack(spacing: 8) {
        PlainButton {
          todo.isDone.toggle()
        } label: {
          todo.isDone
          ? Image.imgCheckActive
            .frame(size: 36)
          : Image.imgCheckDailyInactive
            .frame(size: 36)
        }

        TextField("", text: $todo.content)
          .font(.spoqaHans(size: 15))
          .foregroundStyle(Color.textSecondary)
          .frame(maxWidth: .infinity, alignment: .leading)
          .submitLabel(.done)
          .padding(.top, 8.5)
          .padding(.bottom, 12.5)
          .onSubmit {
            onAddTodo(todo)
          }
      }
      .padding(.leading, 14)
      .padding(.trailing, todo.externalLink.isEmpty ? 20 : 16)
    }
    .background(alignment: .bottom) {
      Color.borderPrimary.frame(height: 1)
        .padding(.horizontal, 20)
    }
  }
}
