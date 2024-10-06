//
//  OnFisrtAppearModifier.swift
//  ModaCore
//
//  Created by 황득연 on 9/21/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct OnFirstAppearModifier: ViewModifier {

  private let action: () -> Void
  @State private var hasAppeared = false

  init(action: @escaping () -> Void) {
    self.action = action
  }

  func body(content: Content) -> some View {
    content
      .onAppear {
        guard !hasAppeared else { return }
        hasAppeared = true
        action()
      }
  }
}

public extension View {
  func onFirstAppear(action: @escaping () -> Void) -> some View {
    return modifier(OnFirstAppearModifier(action: action))
  }
}
