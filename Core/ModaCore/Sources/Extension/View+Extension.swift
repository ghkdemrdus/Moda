//
//  View+Extension.swift
//  ModaData
//
//  Created by 황득연 on 3/18/24.
//

import SwiftUI

public extension View {
  func frame(size: CGFloat? = nil, alignment: Alignment = .center) -> some View {
    frame(width: size, height: size, alignment: alignment)
  }

  func contentTouchable() -> some View {
      self.contentShape(Rectangle()) // 전체 영역에 Gesture 가 동작하기 위해
  }

  func hideKeyboard() {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }

  func background(if condition: Bool, alignment: Alignment = .center, @ViewBuilder content: () -> some View) -> some View {
    self.background(alignment: alignment) {
      if condition {
        content()
      }
    }
  }

  func overlay(if condition: Bool, alignment: Alignment = .center, @ViewBuilder content: () -> some View) -> some View {
    self.overlay(alignment: alignment) {
      if condition {
        content()
      }
    }
  }
}

