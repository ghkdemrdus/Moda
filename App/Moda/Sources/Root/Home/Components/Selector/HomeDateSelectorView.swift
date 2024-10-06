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
  let currentDate: HomeDate

  let onTapDate: (HomeDate) -> Void

  var body: some View {
    content
  }
}

// MARK: - Content

private extension HomeDateSelectorView {
  var content: some View {
    ScrollViewReader { proxy in
      ScrollView(.horizontal) {
        LazyHStack(spacing: 4) {
          ForEach(dates, id: \.date) { date in
            PlainButton(
              action: {
                onTapDate(date)
              },
              label: {
                HomeDateItemView(
                  currentDate: currentDate,
                  date: date
                )
              }
            )
            .id(date)
          }
          .frame(width: 40, height: 64)
        }
        .padding(.horizontal, gradientWidth)
        .onFirstAppear {
          Task { @MainActor in
            proxy.scrollTo(currentDate, anchor: .center)
          }
        }
      }
      .frame(height: 64)
      .gradient([.leading, .trailing], color: .backgroundPrimary, length: gradientWidth)
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
  var gradientWidth: CGFloat {
    let totalWidth = UIScreen.main.bounds.width - (7 * 40 + 6 * 4)
    return totalWidth / 2
  }
}

// MARK: - Previews

#Preview(traits: .sizeThatFitsLayout) {
  @Previewable @State var currentDate: HomeDate = .init(date: .today, timeline: .previous, hasTodo: false)

  HomeDateSelectorView(
    dates: DateManager.shared.homeDatas(from: currentDate.date),
    currentDate: currentDate,
    onTapDate: { currentDate = $0 }
  )
}
