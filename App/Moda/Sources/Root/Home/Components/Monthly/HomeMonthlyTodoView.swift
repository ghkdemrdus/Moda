//
//  HomeMonthlyTodoView.swift
//  Moda
//
//  Created by 황득연 on 9/18/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeMonthlyTodoView: View {

  @Binding var isFolded: Bool
  let todos: [HomeTodo]

  let onTapEdit: () -> Void
  let onTapDone: (HomeTodo) -> Void

  var body: some View {
    content
      .animation(.spring(duration: 0.4), value: isFolded)
  }
}

// MARK: - Content

private extension HomeMonthlyTodoView {
  var content: some View {
    VStack(spacing: 6) {
      HStack {
        Text("먼쓸리 투두")
          .font(.spoqaHans(size: 19, weight: .bold))
          .foregroundStyle(Color.textPrimary)
          .frame(maxWidth: .infinity, alignment: .leading)

        Spacer()

        HStack(spacing: 8) {
          if todos.count > 0 {
            PlainButton(
              action: {
                onTapEdit()
              },
              label: {
                Image.icMonthlyEdit
              }
            )
          }
          
          if todos.count > 3 {
            PlainButton(
              action: {
                isFolded.toggle()
              },
              label: {
                Image.icMonthlyArrow
                  .rotationEffect(isFolded ? .radians(.pi) : .zero)
              }
            )
          }
        }
      }
      .padding(.horizontal, 16)

      if todos.isEmpty {
        Text("이번 달에 할 일들을 가볍게 적어봐요!")
          .font(.spoqaHans(size: 15))
          .foregroundStyle(Color.textInactiveOrange)
          .padding(.top, 8)
          .padding(.bottom, 10)
      } else {
        VStack(spacing: 0) {
          ForEach(Array(todos.prefix(isFolded ? 3 : todos.count).enumerated()), id: \.element.id) { idx, todo in
            HomeMonthlyTodoItemView(
              todo: todos[idx],
              onTapDone: {
                onTapDone($0)
              }
            )
          }
        }
      }
    }
    .padding(.top, 12)
    .padding(.bottom, 6)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.backgroundBrand)
    )
    .padding(.horizontal, 16)
  }
}

// MARK: - Previews

#Preview("투두가 없는 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var isFolded = false
  @Previewable @State var todos = [HomeTodo]()

  HomeMonthlyTodoView(
    isFolded: $isFolded,
    todos: todos,
    onTapEdit: {},
    onTapDone: { _ in }
  )
}

#Preview("투두가 3개 이하인 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var isFolded = false
  @Previewable @State var todos: [HomeTodo] = [.shortMock]

  HomeMonthlyTodoView(
    isFolded: $isFolded,
    todos: todos,
    onTapEdit: {},
    onTapDone: { todo in
      todos.first(where: { $0.id == todo.id })?.isDone.toggle()
    }
  )
}

#Preview("투두가 3개 이상인 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var isFolded: Bool = true
  @Previewable @State var todos: [HomeTodo] = .mock

  HomeMonthlyTodoView(
    isFolded: $isFolded,
    todos: todos,
    onTapEdit: {},
    onTapDone: { todo in
      todos.first(where: { $0.id == todo.id })?.isDone.toggle()
    }
  )
}
