//
//  HomeDailyTodoItemView.swift
//  Moda
//
//  Created by 황득연 on 9/18/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeDailyTodoItemView: View {

  @Binding var todo: Todo

  var body: some View {
      content
  }
}

// MARK: - Content

private extension HomeDailyTodoItemView {
  var content: some View {
    HStack(alignment: .top, spacing: 8) {
      PlainButton(
        action: {
          todo.isDone.toggle()
        },
        label: {
          todo.isDone
          ? Image.imgCheckActive
          : Image.imgCheckDailyInactive
        }
      )

      Text(todo.content)
        .font(.spoqaHans(size: 15))
        .foregroundStyle(Color.textSecondary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 3)
    }
    .padding(.vertical, 10)
    .background(alignment: .bottom) {
      Color.borderPrimary.frame(height: 1)
    }
    .padding(.horizontal, 20.5)
  }
}

// MARK: - Previews

#Preview("1줄인 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var todo: Todo = .init(id: "1", content: "TodoTodo", isDone: true, category: .daily)

  HomeDailyTodoItemView(todo: $todo)
    .loadCustomFonts()
}

#Preview("2줄 이상인 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var todo: Todo = .init(id: "1", content: "TodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodoTodo", isDone: true, category: .daily)

  HomeDailyTodoItemView(todo: $todo)
    .loadCustomFonts()
}
