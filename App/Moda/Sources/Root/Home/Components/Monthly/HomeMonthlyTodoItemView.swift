//
//  HomeMonthlyTodoItemView.swift
//  Moda
//
//  Created by 황득연 on 9/18/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeMonthlyTodoItemView: View {

  @Binding var todo: Todo

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
          todo.isDone.toggle()
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 3)
    }
    .padding(.vertical, 6)
    .padding(.horizontal, 16)
  }
}

// MARK: - Previews

#Preview("1줄인 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var todo: Todo = .init(id: "1", content: "TodoTodo", isDone: true, type: .monthly)

  HomeMonthlyTodoItemView(todo: $todo)
    .loadCustomFonts()
}

#Preview("2줄 이상인 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var todo: Todo = .init(id: "1", content: "TodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodo", isDone: true, type: .monthly)

  HomeMonthlyTodoItemView(todo: $todo)
    .loadCustomFonts()
}
