//
//  ModaCountView.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/10/24.
//

import SwiftUI

struct ModaCountView: View {

  private let totalCount: Int
  private let doneCount: Int

  init(totalCount: Int, doneCount: Int) {
    self.totalCount = totalCount
    self.doneCount = doneCount
  }

  var body: some View {
    ZStack(alignment: .center) {
      HStack(spacing: 0) {
        Text("\(totalCount)/")
          .font(.spoqaHans(size: 14))
          .foregroundColor(.white)

        Text("\(doneCount)")
          .font(.spoqaHans(size: 14))
          .foregroundColor(Color.fogOrange)
      }
      .padding(.vertical, 3)
      .padding(.horizontal, 8)
    }
    .background(
      RoundedRectangle(cornerRadius: 8)
        .fill(Color.slate900)
    )
  }
}
