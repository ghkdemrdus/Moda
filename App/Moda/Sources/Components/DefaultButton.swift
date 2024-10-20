//
//  DefaultButton.swift
//  Moda
//
//  Created by 황득연 on 10/19/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct DefaultButton<Content: View>: View {

  private let action: () -> Void
  private let label: () -> Content

  init(action: @escaping () -> Void, label: @escaping () -> Content) {
    self.action = action
    self.label = label
  }

  var body: some View {
    Button(action: action, label: label)
      .buttonStyle(NoTapAnimationStyle())
  }
}


struct NoTapAnimationStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            // Make the whole button surface tappable. Without this only content in the label is tappable and not whitespace. Order is important so add it before the tap gesture
            .contentShape(Rectangle())
            .onTapGesture(perform: configuration.trigger)
    }
}
