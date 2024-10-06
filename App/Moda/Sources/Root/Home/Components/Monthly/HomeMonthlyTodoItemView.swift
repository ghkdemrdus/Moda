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
    HStack(alignment: .top, spacing: 8) {
      PlainButton(
        action: {
          onTapDone(todo)
        },
        label: {
          todo.isDone
          ? Image.imgCheckActive
          : Image.imgCheckMonthlyInactive
        }
      )

      Text(todo.content)
        .font(.spoqaHans(size: 15))
        .foregroundStyle(Color.textSecondary)
        .lineLimit(nil)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 3)
    }
    .padding(.vertical, 6)
    .padding(.horizontal, 16)
  }
}

// MARK: - Previews

#Preview("1줄인 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var todo: HomeTodo = .init(content: "TodoTodo", category: .monthly)

  HomeMonthlyTodoItemView(todo: todo, onTapDone: { $0.isDone.toggle() })
    .loadCustomFonts()
}

#Preview("2줄 이상인 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var todo: HomeTodo = .init(content: "TodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodo", category: .monthly)

  HomeMonthlyTodoItemView(todo: todo, onTapDone: { $0.isDone.toggle() })
    .loadCustomFonts()
}
