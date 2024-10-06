//
//  HomeDeleteTodoBottomSheet.swift
//  Moda
//
//  Created by 황득연 on 9/22/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeDeleteTodoBottomSheet: View {

  @Binding var isPresented: Bool

  let todo: HomeTodo?

  let onTapDelete: (HomeTodo) -> Void

  var body: some View {
    ZStack(alignment: .bottom) {
      Color.black
        .opacity(isPresented ? 0.5 : 0)
        .onTapGesture {
          isPresented = false
        }

      if isPresented {
        VStack(spacing: 12) {
          HStack(spacing: 10) {
            Image.icDelete

            VStack(alignment: .leading) {
              HStack(spacing: 0) {
                Text("'")
                Text(todo?.content ?? "")
                Text("'")
                Spacer()
              }

              Text("투두를 삭제할까요?")
            }
            .font(.spoqaHans(size: 17))
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(1)
          }
          .padding(.vertical, 5)
          .padding(.horizontal, 24)

          PlainButton(
            action: {
              guard let todo else { return }
              onTapDelete(todo)
              isPresented = false
            },
            label: {
              Text("좋아요!")
                .font(.spoqaHans(size: 16, weight: .bold))
                .foregroundStyle(.white)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(
                  RoundedRectangle(cornerRadius: 12)
                    .fill(Color.brandStrong)
                )
            }
          )
          .padding(.horizontal, 24)
        }
        .padding(.vertical, 16)
        .padding(.bottom, UIApplication.shared.safeAreaBottomHeight)
        .background(
          Color.backgroundPrimary
            .clipShape(.rect(topLeadingRadius: 16, topTrailingRadius: 16))
        )
        .zIndex(1)
        .transition(.move(edge: .bottom))
      }
    }
    .zIndex(2)
    .animation(.spring(duration: 0.4), value: isPresented)
  }
}
