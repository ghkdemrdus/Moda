//
//  HomeDailyTodoView.swift
//  Moda
//
//  Created by 황득연 on 9/18/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeDailyTodoView: View {

  let todos: [HomeTodo]

  let onTapEdit: () -> Void
  let onTapDone: (HomeTodo) -> Void

  var body: some View {
    content
  }
}

// MARK: - Content

private extension HomeDailyTodoView {
  var content: some View {
    VStack(spacing: 0) {
      HStack {
        Text("데일리 투두")
          .font(.spoqaHans(size: 19, weight: .bold))
          .foregroundStyle(Color.textPrimary)
          .frame(maxWidth: .infinity, alignment: .leading)

        if todos.count > 0 {
          PlainButton(
            action: {
              onTapEdit()
            },
            label: {
              Image.icDailyEdit
            }
          )
        }
      }
      .padding(.horizontal, 20.5)

      if todos.isEmpty {
        VStack(spacing: 24) {
          Image.imgDailyEmpty

          Text("오늘의 할 일을 가벼운 마음으로\n적어볼까요?")
            .font(.spoqaHans(size: 15))
            .foregroundStyle(Color.textInactive)
            .lineLimit(2)
            .multilineTextAlignment(.center)
        }
        .padding(.top, 56)
        .padding(.bottom, 30)
      } else {
        VStack(spacing: 0) {
          ForEach(todos, id: \.id) { todo in
            HomeDailyTodoItemView(
              todo: todo,
              onTapDone: onTapDone
            )
          }
        }
        .padding(.top, 4)
      }
    }
    .background(Color.backgroundPrimary)
  }
}

// MARK: - Previews

#Preview("투두가 없는 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var todos: [HomeTodo] = []

  HomeDailyTodoView(
    todos: todos,
    onTapEdit: {},
    onTapDone: { _ in }
  )
}

#Preview("투두가 있는 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var todos: [HomeTodo] = .mock

  HomeDailyTodoView(
    todos: todos,
    onTapEdit: {},
    onTapDone: { _ in }
  )
}
