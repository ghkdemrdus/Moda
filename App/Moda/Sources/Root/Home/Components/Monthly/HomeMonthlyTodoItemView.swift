//
//  HomeMonthlyTodoItemView.swift
//  Moda
//
//  Created by 황득연 on 9/18/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeMonthlyTodoItemView: View {

  let todo: HomeTodo

  let onTapDone: (HomeTodo) -> Void

  var body: some View {
    content
  }
}

// MARK: - Content

private extension HomeMonthlyTodoItemView {
  var content: some View {
    HStack(alignment: .top, spacing: 2) {
      PlainButton(
        action: {
          onTapDone(todo)
        },
        label: {
          todo.isDone
          ? Image.imgCheckActive
            .frame(size: 36)
          : Image.imgCheckMonthlyInactive
            .frame(size: 36)
        }
      )

      Text(todo.content)
        .font(.spoqaHans(size: 15))
        .foregroundStyle(Color.textSecondary)
        .lineLimit(nil)
        .strikethrough(todo.isDone)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 9)
    }
    .padding(.leading, 10)
    .padding(.trailing, 16)
  }
}

// MARK: - Previews

#Preview("1줄인 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var todo: HomeTodo = .shortMock

  HomeMonthlyTodoItemView(
    todo: todo,
    onTapDone: {
      $0.isDone.toggle()
    }
  )
}

#Preview("2줄 이상인 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var todo: HomeTodo = .longMock

  HomeMonthlyTodoItemView(
    todo: todo,
    onTapDone: {
      $0.isDone.toggle()
    }
  )
}
