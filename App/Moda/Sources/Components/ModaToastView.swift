//
//  ModaToastView.swift
//  Moda
//
//  Created by 황득연 on 10/6/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct ModaToastView: View {

  let type: ModaToastManager.BottomType

  init(_ type: ModaToastManager.BottomType) {
    self.type = type
  }

  var body: some View {
    HStack(spacing: 12) {
      type.icon

      Text(type.text)
        .font(.spoqaHans(size: 15))
        .lineLimit(1)
        .foregroundStyle(Color.textPrimary)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 12)
    .background(
      Capsule()
        .fill(Color.backgroundSecondary)
        .shadow(color: .black.opacity(0.15), radius: 10)
    )
    .padding(.horizontal, 16)
    .id(type)
  }
}

// MARK: - Preview

#Preview {
  ModaToastView(.deleteTodo)
}
