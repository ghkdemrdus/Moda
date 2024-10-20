//
//  BookmarkTodoInputBottomSheet.swift
//  Moda
//
//  Created by 황득연 on 10/20/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct BookmarkTodoInputBottomSheet: View {

  enum Option {
    case externalLink
    case memo
  }
  
  @Bindable var todo: BookmarkTodo

  @State var isExternalLinkActive: Bool
  @State var isMemoActive: Bool

  @State var externalLink: String
  @State var memo: String

  @State var isPresented: Bool = false

  @FocusState var focused: Option?

  let onTapConfirm: () -> Void

  init(
    todo: BookmarkTodo,
    onTapConfirm: @escaping () -> Void
  ) {
    self.todo = todo
    self.isExternalLinkActive = !todo.externalLink.isEmpty
    self.isMemoActive = !todo.memo.isEmpty
    self.externalLink = todo.externalLink
    self.memo = todo.memo
    self.onTapConfirm = onTapConfirm
  }

  var body: some View {
    content
      .onAppear {
        animatePresenting()
      }
  }

  private func animatePresenting() {
    withAnimation(.spring(duration: 0.4)) {
      isPresented = true
    }
  }

  private func animateDismissing() {
    withAnimation(.spring(duration: 0.4)) {
      isPresented = false
    } completion: {
      onTapConfirm()
    }
  }
}

private extension BookmarkTodoInputBottomSheet {
  var content: some View {
    ZStack(alignment: .bottom) {
      Color.black
        .opacity(isPresented ? 0.5 : 0)

      if isPresented {
        VStack(spacing: 16) {
          Text(todo.content)
            .font(.spoqaHans(size: 18, weight: .bold))
            .foregroundStyle(Color.textPrimary)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)

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

              PlainButton {
                if !isExternalLinkActive {
                  todo.externalLink = ""
                }

                if !isMemoActive {
                  todo.memo = ""
                }
                hideKeyboard()
                animateDismissing()
              } label: {
                Text("완료")
                  .font(.spoqaHans(size: 14, weight: .bold))
                  .foregroundStyle(Color.iconTertiary)
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
            }
          }
          .padding(.top, 8)
          .padding(.bottom, 16)
          .padding(.horizontal, 24)
          .background(Color.backgroundTertiary)
          .overlay(alignment: .top) {
            Color.borderPrimary.frame(height: 1)
          }
        }
        .padding(.top, 24)
        .padding(.bottom, focused != nil ? 0 : UIApplication.shared.safeAreaBottomHeight)
        .background(
          Color.backgroundPrimary
            .clipShape(.rect(topLeadingRadius: 16, topTrailingRadius: 16))
        )
        .zIndex(1)
        .transition(.move(edge: .bottom))
      }
    }
    .ignoresSafeArea(.container)
    .transition(.move(edge: .bottom))
  }
}
