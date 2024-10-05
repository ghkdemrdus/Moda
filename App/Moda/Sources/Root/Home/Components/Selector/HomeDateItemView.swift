//
//  HomeDateItemView.swift
//  Moda
//
//  Created by 황득연 on 9/18/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeDateItemView: View {

  let currentDate: HomeDate
  let date: HomeDate

  var body: some View {
    content
  }
}

// MARK: - Content

private extension HomeDateItemView {
  var content: some View {
    VStack(spacing: 12) {
      Text(date.date.format(.weekday))
        .font(.spoqaHans(size: 13, weight: .bold))
        .foregroundStyle(dayColor)

      Text("\(date.date.day)")
        .font(.spoqaHans(size: 13, weight: .bold))
        .foregroundStyle(dayColor)
        .background(if: date.timeline == .current) {
          RoundedRectangle(cornerRadius: 6)
            .fill(dayBgColor)
            .frame(width: 32, height: 32)
        }
        .background(if: date.timeline == .previous && currentDate == date) {
          Circle()
            .stroke(dayBgColor, lineWidth: 1)
            .frame(width: 32, height: 32)
        }
        .background(if: date.timeline == .following && currentDate == date) {
          Circle()
            .fill(dayBgColor)
            .frame(width: 32, height: 32)
        }
    }
    .frame(width: 40, height: 64)
  }
}

// MARK: - Properties

private extension HomeDateItemView {
  var dayColor: Color {
    switch date.timeline {
    case .current: return .textPrimary
    case .previous: return .brandSecondary
    case .following: return .textSecondary
    }
  }

  var dayBgColor: Color {
    switch date.timeline {
    case .current: return .brandPrimary
    case .previous: return .brandPrimary
    case .following: return .brandTertiary
    }
  }
}

// MARK: - Previews

#Preview("오늘인 경우") {
  let date: HomeDate = .init(date: Date.now, timeline: .current, hasTodo: false)

  HomeDateItemView(
    currentDate: date,
    date: date
  )
  .loadCustomFonts()
}

#Preview("과거인 경우") {
  let date: HomeDate = .init(date: Date.now, timeline: .previous, hasTodo: false)

  HomeDateItemView(
    currentDate: date,
    date: date
  )
  .loadCustomFonts()
}

#Preview("미래인 경우") {
  let date: HomeDate = .init(date: Date.now, timeline: .following, hasTodo: false)

  HomeDateItemView(
    currentDate: date,
    date: date
  )
  .loadCustomFonts()
}
