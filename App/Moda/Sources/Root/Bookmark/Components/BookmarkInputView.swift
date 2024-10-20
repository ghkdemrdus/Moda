//
//  BookmarkInputView.swift
//  Moda
//
//  Created by 황득연 on 10/19/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct BookmarkInputView: View {

  enum Option {
    case externalLink
    case memo
  }

  @Bindable var todo: BookmarkTodo

  @State var isExternalLinkActive: Bool = false
  @State var isMemoActive: Bool = false

  @State var externalLink: String = ""
  @State var memo: String = ""

  @FocusState var focused: Option?

  let onAddTodo: (BookmarkTodo) -> Void
  let onLoseFocus: () -> Void

  init(
    todo: BookmarkTodo,
    onAddTodo: @escaping (BookmarkTodo) -> Void,
    onLoseFocus: @escaping () -> Void
  ) {
    self.todo = todo
    self.isExternalLinkActive = !todo.externalLink.isEmpty
    self.isMemoActive = !todo.memo.isEmpty
    self.externalLink = todo.externalLink
    self.memo = todo.memo
    self.onAddTodo = onAddTodo
    self.onLoseFocus = onLoseFocus
  }

  var body: some View {
    content
      .onChange(of: isExternalLinkActive) {
        guard !$1, focused == .externalLink else { return }
        if isMemoActive {
          focused = .memo
        } else {
          onLoseFocus()
        }
      }
      .onChange(of: isMemoActive) {
        guard !$1, focused == .memo else { return }
        if isExternalLinkActive {
          focused = .externalLink
        } else {
          onLoseFocus()
        }
      }
  }
}

// MARK: - Content

private extension BookmarkInputView {
  var content: some View {
    VStack(spacing: 10) {
      HStack(spacing: 8) {
        DefaultButton {
          isExternalLinkActive.toggle()
        } label: {
          isExternalLinkActive
          ? Image.icBookmarkLinkActive
          : Image.icBookmarkLinkInactive
        }

        DefaultButton {
          isMemoActive.toggle()
        } label: {
          isMemoActive
          ? Image.icBookmarkMemoActive
          : Image.icBookmarkMemoInactive
        }

        Spacer()

        if isExternalLinkActive || isMemoActive {
          PlainButton {
            onAddTodo(todo)
          } label: {
            Text("완료")
              .font(.spoqaHans(size: 14, weight: .bold))
              .foregroundStyle(Color.iconTertiary)
          }
        }
      }

      if isExternalLinkActive || isMemoActive {
        VStack(spacing: 8) {
          if isExternalLinkActive {
            TextField(
              "",
              text: $todo.externalLink,
              prompt: Text("링크를 붙여넣어 주세요").foregroundStyle(Color.textInactive)
            )
            .font(.spoqaHans(size: 13, weight: .regular))
            .foregroundStyle(Color.textSecondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .submitLabel(.done)
            .padding(12)
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(Color.backgroundPrimary)
            )
            .focused($focused, equals: .externalLink)
            .onAppear{
              focused = .externalLink
            }
          }

          if isMemoActive {
            TextEditor(text: $todo.memo)
//            TextField("메모 내용을 입력해주세요", text: $todo.memo, axis: .vertical)
              .frame(maxWidth: .infinity, alignment: .leading)
              .submitLabel(.return)
              .padding(.vertical, 12)
              .padding(.horizontal, 8)
              .frame(height: 72)
              .focused($focused, equals: .memo)
              .scrollContentBackground(.hidden)
              .background(if: todo.memo.isEmpty, alignment: .topLeading) {
                TextEditor(text: .constant("메모 내용을 입력해주세요"))
                  .foregroundStyle(Color.textInactive)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .scrollContentBackground(.hidden)
                  .padding(.vertical, 12)
                  .padding(.horizontal, 8)
              }
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color.backgroundPrimary)
              )
              .scrollDismissesKeyboard(.never)
              .onAppear{
                focused = .memo
              }
          }
        }
        .font(.spoqaHans(size: 13, weight: .regular))
        .padding(.bottom, 8)
      }
    }
    .padding(.vertical, 8)
    .padding(.horizontal, 20)
    .background(Color.backgroundTertiary)
  }
}
