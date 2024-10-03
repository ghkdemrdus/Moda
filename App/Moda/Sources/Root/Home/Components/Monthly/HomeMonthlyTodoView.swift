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
  @Binding var todos: [Todo]

  let onTapEdit: () -> Void

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
            HomeMonthlyTodoItemView(todo: $todos[idx])
          }
        }
      }
    }
    .padding(.top, 12)
    .padding(.bottom, 6)
    .background(
      RoundedRectangle(cornerRadius: 7)
        .fill(Color.backgroundBrand)
    )
    .padding(.horizontal, 16)
  }
}

// MARK: - Previews

#Preview("투두가 없는 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var isFolded = false
  @Previewable @State var todos = [Todo]()

  HomeMonthlyTodoView(
    isFolded: $isFolded,
    todos: $todos,
    onTapEdit: {}
  )
  .loadCustomFonts()
}

#Preview("투두가 3개 이하인 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var isFolded = false
  @Previewable @State var todos: [Todo] = [
    .init(id: "1", content: "Todo1", isDone: true, category: .monthly),
    .init(id: "2", content: "Todo2", isDone: true, category: .monthly)
  ]

  HomeMonthlyTodoView(
    isFolded: $isFolded,
    todos: $todos,
    onTapEdit: {}
  )
  .loadCustomFonts()
}

#Preview("투두가 3개 이상인 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var isFolded: Bool = true
  @Previewable @State var todos: [Todo] = [
    .init(id: "1", content: "Todo1", isDone: true, category: .monthly),
    .init(id: "2", content: "Todo2", isDone: true, category: .monthly),
    .init(id: "3", content: "Todo3", isDone: false, category: .monthly),
    .init(id: "4", content: "Todo4", isDone: false, category: .monthly),
    .init(id: "5", content: "Todo5Todo5Todo5Todo5Todo5Todo5Todo5Todo5Todo5Todo5", isDone: false, category: .monthly)
  ]

  HomeMonthlyTodoView(
    isFolded: $isFolded,
    todos: $todos,
    onTapEdit: {}
  )
  .loadCustomFonts()
}
