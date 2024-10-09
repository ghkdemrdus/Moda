//
//  ModaToastModifier.swift
//  Moda
//
//  Created by 황득연 on 10/6/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct ModaToastModifier: ViewModifier {
  @ObservedObject var manager = ModaToastManager.shared

  @State var offset: CGFloat = 100

  func body(content: Content) -> some View {
    content
      .overlay {
        VStack {
          Spacer()
          if manager.isPresented {
            ModaToastView(manager.type)
              .transition(.move(edge: .bottom))
              .padding(.bottom, 50)
          }
        }
        .ignoresSafeArea()
      }
      .animation(.spring(duration: 0.4), value: manager.isPresented)
  }
}

public extension View {
  func toast() -> some View {
    modifier(ModaToastModifier())
  }
}

// MARK: - Preview

#Preview {
  VStack(spacing: 16) {
    Button("Show Toast1") {
      Task {
        await ModaToastManager.shared.show(.deleteTodo)
      }
    }

    Button("Show Toast2") {
      Task {
        await ModaToastManager.shared.show(.delayTodo)
      }
    }
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .toast()
}
