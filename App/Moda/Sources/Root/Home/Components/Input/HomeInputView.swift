//
//  HomeInputView.swift
//  Moda
//
//  Created by 황득연 on 9/18/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeInputView: View {

  @State var todo: String = ""
  @State var type: Todo.`Type` = .monthly

  let onTapAdd: (Todo.`Type`, String) -> Void

  var body: some View {
    content
  }
}

// MARK: - Content

private extension HomeInputView {
  var content: some View {
    HStack(spacing: 0) {
      PlainButton(
        action: {
          type = .monthly
        },
        label: {
          Text("M")
            .font(.spoqaHans(size: 13, weight: .bold))
            .frame(size: 32)
            .background(
              RoundedRectangle(cornerRadius: 4)
                .fill(type == .monthly ? Color.brandTertiary : .clear)
            )
        }
      )

      PlainButton(
        action: {
          type = .daily
        },
        label: {
          Text("D")
            .font(.spoqaHans(size: 13, weight: .bold))
            .frame(size: 32)
            .background(
              RoundedRectangle(cornerRadius: 4)
                .fill(type == .daily ? Color.brandTertiary : .clear)
            )
        }
      )

      TextField("", text: $todo)
        .font(.spoqaHans(size: 15))
        .foregroundStyle(Color.textSecondary)
        .padding(.leading, 12)
        .padding(.trailing, 36)
        .background(
          Capsule()
            .fill(Color.backgroundSecondary)
            .frame(height: 32)
        )
        .padding(.leading, 8)
        .overlay(if: !todo.isEmpty, alignment: .trailing) {
          PlainButton(
            action: {
              onTapAdd(type, todo)
              todo = ""
              hideKeyboard()
            },
            label: {
              Image.imgCheckActive
                .padding(.trailing, 6)
            }
          )
        }
        .onSubmit {
          guard !todo.isEmpty else { return }
          onTapAdd(type, todo)
          todo = ""
        }
    }
    .padding(.vertical, 8)
    .padding(.horizontal, 16)
    .background(alignment: .top) {
      Color.borderPrimary.frame(height: 1)
    }
  }
}

// MARK: - Previews

#Preview(traits: .sizeThatFitsLayout) {
  @Previewable @State var type: Todo.`Type` = .monthly
  @Previewable @State var todo: String = "Todo"

  HomeInputView(todo: todo, type: type, onTapAdd: { _, _ in })
    .loadCustomFonts()
}
