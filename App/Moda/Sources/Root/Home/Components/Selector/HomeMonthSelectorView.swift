//
//  HomeMonthSelectorView.swift
//  Moda
//
//  Created by 황득연 on 9/17/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeMonthSelectorView: View {

  let currentDate: Date
  let onChangeMonth: (Int) -> Void

  var body: some View {
    content
  }
}

private extension HomeMonthSelectorView {
  @ViewBuilder var content: some View {
    HStack(spacing: 0) {
      HStack {
        Text("\(currentDate.format(.month))")
          .font(.spoqaHans(size: 28, weight: .bold))
          .foregroundStyle(Color.textPrimary)

        Text("\(currentDate.format(.monthText))")
          .font(.spoqaHans(size: 18, weight: .bold))
          .foregroundStyle(Color.textPrimary)
      }

      Spacer()

      HStack(spacing: 8) {
        PlainButton(
          action: {
            onChangeMonth(-1)
          },
          label: {
            Image.icArrow
              .rotationEffect(.radians(.pi))
              .frame(size: 32)
              .background(
                Circle()
                  .fill(Color.backgroundSecondary)
              )
          }
        )

        PlainButton(
          action: {
            onChangeMonth(1)
          },
          label: {
            Image.icArrow
              .frame(size: 32)
              .background(
                Circle()
                  .fill(Color.backgroundSecondary)
              )
          }
        )
      }
    }
    .frame(height: 40)
    .padding(.horizontal, 20)
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  HomeMonthSelectorView(currentDate: .today, onChangeMonth: { _ in })
    .loadCustomFonts()
}
