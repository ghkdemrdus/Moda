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

  @Bindable var todo: HomeTodo
  @Binding var isDragging: Bool

  let onTapDelete: (HomeTodo) -> Void
  let onTapDelay: (HomeTodo) -> Void

  let startDragging: (Int, HomeTodo) -> Void
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
        .submitLabel(.done)

      PlainButton(
        action: {
          hideKeyboard()
          onTapDelete(todo)
        },
        label: {
          Image.icDailyTrash
        }
      )

      PlainButton(
        action: {
          hideKeyboard()
          onTapDelay(todo)
        },
        label: {
          Image.icDailyDelay
        }
      )

      Image.icDailyReorder
        .highPriorityGesture(
          DragGesture(minimumDistance: 0)
            .onChanged { value in
              if !isDragging {
                hideKeyboard()
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

// MARK: - Preview

#Preview(traits: .sizeThatFitsLayout) {
  HomeDailyTodoEditItemView(
    idx: 0,
    todo: .shortMock,
    isDragging: .constant(false),
    onTapDelete: { _ in },
    onTapDelay: { _ in },
    startDragging: { _, _ in },
    updateDragging: { _ in },
    endDragging: {}
  )
}
