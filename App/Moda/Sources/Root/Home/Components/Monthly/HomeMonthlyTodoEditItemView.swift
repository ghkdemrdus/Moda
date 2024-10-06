//
//  HomeMonthlyTodoEditItemView.swift
//  Moda
//
//  Created by 황득연 on 9/28/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeMonthlyTodoEditItemView: View {

  static let height: CGFloat = 36

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

private extension HomeMonthlyTodoEditItemView {
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
          Image.icMonthlyTrash
        }
      )

      PlainButton(
        action: {
          hideKeyboard()
          onTapDelay(todo)
        },
        label: {
          Image.icMonthlyDelay
        }
      )

      Image.icMonthlyReorder
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
    .padding(.horizontal, 16)
  }
}

// MARK: - Previews
