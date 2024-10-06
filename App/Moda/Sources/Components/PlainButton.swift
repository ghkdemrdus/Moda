//
//  PlainButton.swift
//  moda
//
//  Created by 황득연 on 4/7/24.
//

import SwiftUI

struct PlainButton<Content: View>: View {

  private let action: () -> Void
  private let label: () -> Content

  init(action: @escaping () -> Void, label: @escaping () -> Content) {
    self.action = action
    self.label = label
  }

  var body: some View {
    Button(action: action, label: label)
      .buttonStyle(PlainButtonStyle())
  }
}

// MARK: - Preview

#Preview {
  PlainButton(action: {}, label: { Color.blue.frame(size: 200) })
}
