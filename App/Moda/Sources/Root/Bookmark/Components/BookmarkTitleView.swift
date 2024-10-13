//
//  BookmarkTitleView.swift
//  Moda
//
//  Created by 황득연 on 10/13/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct BookmarkTitleView: View {

  @Binding var currentDate: Date

  var body: some View {
    content
  }
}

private extension BookmarkTitleView {
  @ViewBuilder var content: some View {
    HStack {
      Text(String(currentDate.year))
        .font(.spoqaHans(size: 28, weight: .bold))
        .foregroundStyle(Color.textPrimary)

      Spacer()

      HStack(spacing: 8) {
        PlainButton {
          currentDate = currentDate.addYear(-1)
        } label: {
          Image.icArrow
            .rotationEffect(.radians(.pi))
            .frame(size: 32)
            .background(
              Circle()
                .fill(Color.backgroundSecondary)
            )
        }

        PlainButton {
          currentDate = currentDate.addYear(1)
        } label: {
          Image.icArrow
            .frame(size: 32)
            .background(
              Circle()
                .fill(Color.backgroundSecondary)
            )
        }
      }
    }
    .padding(.horizontal, 20)
  }
}

// MARK: - Preview

#Preview {
  @Previewable @State var date: Date = .today
  
  BookmarkTitleView(currentDate: $date)
}
