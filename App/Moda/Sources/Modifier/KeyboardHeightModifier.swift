//
//  KeyboardHeightModifier.swift
//  Moda
//
//  Created by 황득연 on 10/19/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Combine
import SwiftUI

struct KeyboardHeightModifier: ViewModifier {

  var height: Binding<CGFloat>

  func body(content: Content) -> some View {
    content
      .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification),
                 perform: { notification in
        guard let userInfo = notification.userInfo,
              let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        self.height.wrappedValue = keyboardRect.height

      }).onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification),
                   perform: { _ in
        self.height.wrappedValue = 0
      })
  }
}


public extension View {
  func keyboardHeight(_ state: Binding<CGFloat>) -> some View {
    self.modifier(KeyboardHeightModifier(height: state))
  }
}
