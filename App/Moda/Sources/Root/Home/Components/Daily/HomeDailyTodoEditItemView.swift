//
//  HomeDailyTodoEditItemView.swift
//  Moda
//
//  Created by 황득연 on 9/29/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeDailyTodoEditItemView: View {

  static let height: CGFloat = 46

  let idx: Int

  @Binding var todo: Todo
  @Binding var isDragging: Bool

  let onTapDelete: (Todo) -> Void
  let onTapDelay: (Todo) -> Void

  let startDragging: (Int, Todo) -> Void
  let updateDragging: (DragGesture.Value) -> Void
  let endDragging: () -> Void

  var body: some View {
    content
  }
}

// MARK: - Content

private extension HomeDailyTodoEditItemView {
  var content: some View {
    HStack(spacing: 4) {
      TextField("", text: $todo.content)
        .font(.spoqaHans(size: 14))
        .foregroundStyle(Color.textSecondary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .underline()

      PlainButton(
        action: {
          onTapDelete(todo)
        },
        label: {
          Image.icDailyTrash
        }
      )

      PlainButton(
        action: {
          onTapDelay(todo)
        },
        label: {
          Image.icDailyDelay
        }
      )

      Image.icDailyReorder
        .gesture(
          DragGesture()
            .onChanged { value in
              if !isDragging {
                startDragging(idx, todo)
              }
              updateDragging(value)
            }
            .onEnded { _ in
              if isDragging {
                endDragging()
              }
            }
        )
    }
    .frame(height: Self.height)
    .background(alignment: .bottom) {
      Color.borderPrimary.frame(height: 1)
    }
    .padding(.horizontal, 20.5)
  }
}
