//
//  PositionOffsetPreferenceKey.swift
//  ModaCore
//
//  Created by 황득연 on 9/29/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

private struct PositionOffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  static func reduce(value: inout Value, nextValue: () -> Value) {
    value += nextValue()
  }
}

public extension View {
  func onChangePosition(onChange: @escaping (CGFloat) -> Void) -> some View {
    background(
      GeometryReader { proxy in
        let offset = proxy.frame(in: .named("ScrollView")).minY
        Color.clear.preference(key: PositionOffsetPreferenceKey.self, value: offset)
      }
    )
    .onPreferenceChange(PositionOffsetPreferenceKey.self, perform: onChange)
  }
}
