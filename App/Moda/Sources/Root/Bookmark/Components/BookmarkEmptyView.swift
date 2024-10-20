//
//  BookmarkEmptyView.swift
//  Moda
//
//  Created by 황득연 on 10/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct BookmarkEmptyView: View {
  var body: some View {
    VStack {
      Spacer()
      VStack(spacing: 16) {
        Image.imgBookmarkEmpty

        Text("이번 연도에도 여행, 책, 레시피 등\n잊고 싶지 않은 리스트를 모다와 만들어가요!")
          .font(.spoqaHans(size: 15))
          .foregroundStyle(Color.textInactive)
          .multilineTextAlignment(.center)
      }
      Spacer(); Spacer()
    }
  }
}

// MARK: - Preview

#Preview {
  BookmarkEmptyView()
}
