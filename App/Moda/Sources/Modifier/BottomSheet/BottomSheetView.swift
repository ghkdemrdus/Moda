//
//  BottomSheetView.swift
//  Moda
//
//  Created by 황득연 on 10/19/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct BottomSheetView: View {

  let config: BottomSheetConfiguration
  let onTapConfirm: () -> Void

  init(
    config: BottomSheetConfiguration,
    onTapConfirm: @escaping () -> Void
  ) {
    self.config = config
    self.onTapConfirm = onTapConfirm
  }

  var body: some View {
    VStack(spacing: 12) {
      config.content

      PlainButton {
        onTapConfirm()
      } label: {
        Text(config.buttonText)
          .font(.spoqaHans(size: 16, weight: .bold))
          .foregroundStyle(.white)
          .padding(.vertical, 14)
          .frame(maxWidth: .infinity)
          .background(
            RoundedRectangle(cornerRadius: 12)
              .fill(Color.brandStrong)
          )
      }
    }
    .padding(.top, 24)
    .padding(.bottom, 12 + UIApplication.shared.safeAreaBottomHeight)
    .padding(.horizontal, 24)
    .background(
      Color.backgroundPrimary
        .clipShape(.rect(topLeadingRadius: 16, topTrailingRadius: 16))
    )
    .zIndex(1)
    .transition(.move(edge: .bottom))
  }
}
