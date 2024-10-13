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
  @State var offset: CGSize = .zero

  func body(content: Content) -> some View {
    content
      .overlay {
        VStack {
          Spacer()
          if manager.isPresented {
            ModaToastView(manager.type)
              .transition(.move(edge: .bottom))
              .padding(.bottom, manager.type.isDone ? 100 : 50)
              .offset(offset)
              .gesture(dragGesture)
          }
        }
        .ignoresSafeArea()
      }
      .animation(.spring(duration: 0.4), value: manager.isPresented)
  }

  var dragGesture: some Gesture {
    DragGesture(minimumDistance: 0)
      .onChanged { value in
        manager.cancelCountdown()

        let translation = value.translation
        let xSign = translation.width > 0 ? 1.0 : -1.0
        let width = xSign * log2(1 + abs(Double(translation.width)))

        let height: CGFloat
        if translation.height < 0 {
          height = -log2(1 + abs(Double(translation.height)))
        } else {
          height = translation.height
        }

        offset = .init(width: width, height: height)
      }
      .onEnded { value in
        if value.velocity.height > 100 {
          manager.dismiss()
          offset = .zero
        } else {
          manager.startHideTask()
          withAnimation(.spring(duration: 0.4)) {
            offset = .zero
          }
        }
      }
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
    Button("Show Delete Toast") {
      Task {
        await ModaToastManager.shared.show(.deleteTodo)
      }
    }

    Button("Show Delay Toast") {
      Task {
        await ModaToastManager.shared.show(.delayTodo)
      }
    }

    Button("Show Done Toast") {
      Task {
        await ModaToastManager.shared.show(.doneTodo("참 잘했어요"))
      }
    }

    Button("Show Custom Toast") {
      Task {
        await ModaToastManager.shared.show(.custom("Custom Toast"))
      }
    }
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .toast()
}
