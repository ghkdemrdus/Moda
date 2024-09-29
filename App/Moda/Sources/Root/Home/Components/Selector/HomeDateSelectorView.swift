//
//  HomeDateSelectorView.swift
//  Moda
//
//  Created by 황득연 on 9/18/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeDateSelectorView: View {

  let dates: [HomeDate]
  @Binding var currentDate: HomeDate

  var body: some View {
    content
  }
}

// MARK: - Content

private extension HomeDateSelectorView {
  var content: some View {
    ScrollViewReader { proxy in
      ScrollView(.horizontal) {
        LazyHStack(spacing: dateSpacing) {
          ForEach(dates, id: \.date) { date in
            PlainButton(
              action: {
                currentDate = date
              },
              label: {
                HomeDateItemView(
                  currentDate: $currentDate,
                  date: date
                )
              }
            )
            .id(date)
          }
          .frame(width: 40, height: 64)
        }
        .onFirstAppear {
          Task { @MainActor in
            proxy.scrollTo(currentDate, anchor: .center)
          }
        }
      }
      .frame(height: 64)
      .onChange(of: currentDate) {
        Task { @MainActor in
          withAnimation {
            proxy.scrollTo(currentDate, anchor: .center)
          }
        }
      }
    }
    .padding(.horizontal, 16)
    .scrollIndicators(.hidden)
  }
}

// MARK: - Properties

private extension HomeDateSelectorView {
  var dateSpacing: CGFloat {
    let totalPadding = UIScreen.main.bounds.width - (7 * 40 + 2 * 16)
    return totalPadding / 6
  }
}

// MARK: - Previews

#Preview(traits: .sizeThatFitsLayout) {
  @Previewable @State var currentDate: HomeDate = .init(date: .today, timeline: .previous, hasTodo: false)

  HomeDateSelectorView(
    dates: DateManager.shared.homeDatas(from: currentDate.date),
    currentDate: $currentDate
  )
  .loadCustomFonts()
}
