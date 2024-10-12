//
//  ModaToastView.swift
//  Moda
//
//  Created by 황득연 on 10/6/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct ModaToastView: View {

  let type: ModaToastManager.`Type`

  init(_ type: ModaToastManager.`Type`) {
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
    .padding(.leading, 24)
    .padding(.vertical, 16)
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
