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

  let category: HomeTodo.Category

  let onTapAdd: (HomeTodo.Category, String) -> Void
  let onTapCategory: (HomeTodo.Category) -> Void

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
          onTapCategory(.monthly)
        },
        label: {
          Text("M")
            .font(.spoqaHans(size: 13, weight: .bold))
            .frame(size: 32)
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(category == .monthly ? Color.brandTertiary : .clear)
            )
        }
      )

      PlainButton(
        action: {
          onTapCategory(.daily)
        },
        label: {
          Text("D")
            .font(.spoqaHans(size: 13, weight: .bold))
            .frame(size: 32)
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(category == .daily ? Color.brandTertiary : .clear)
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
              onTapAdd(category, todo)
              todo = ""
            },
            label: {
              Image.imgSend
                .padding(.trailing, 6)
            }
          )
        }
        .submitLabel(.done)
        .onSubmit {
          guard !todo.isEmpty else { return }
          onTapAdd(category, todo)
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
  @Previewable @State var category: HomeTodo.Category = .monthly
  @Previewable @State var todo: String = "가나다라마바사아"

  HomeInputView(
    todo: todo,
    category: category,
    onTapAdd: { _, _ in todo = "" },
    onTapCategory: { category = $0 }
  )
}
