//
//  HomeDailyTodoView.swift
//  Moda
//
//  Created by 황득연 on 9/18/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeDailyTodoView: View {

  @Binding var todos: [Todo]

  let onTapEdit: () -> Void

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
            .multilineTextAlignment(.center)
        }
        .padding(.vertical, 66)
      } else {
        VStack(spacing: 0) {
          ForEach(Array(todos.enumerated()), id: \.element.id) { idx, todo in
            HomeDailyTodoItemView(todo: $todos[idx])
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
  @Previewable @State var todos: [Todo] = []

  HomeDailyTodoView(
    todos: $todos,
    onTapEdit: {}
  )
  .loadCustomFonts()
}

#Preview("투두가 있는 경우", traits: .sizeThatFitsLayout) {
  @Previewable @State var todos: [Todo] = [
    .init(id: "1", content: "Todo1", isDone: true, type: .daily),
    .init(id: "2", content: "Todo2", isDone: true, type: .daily),
    .init(id: "3", content: "Todo3", isDone: false, type: .daily),
    .init(id: "4", content: "Todo4", isDone: false, type: .daily),
    .init(id: "5", content: "Todo5Todo5Todo5Todo5Todo5Todo5Todo5Todo5Todo5Todo5Todo5", isDone: false, type: .daily)
  ]

  HomeDailyTodoView(
    todos: $todos,
    onTapEdit: {}
  )
  .loadCustomFonts()
}
