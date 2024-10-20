//
//  BookmarkEditItemView.swift
//  Moda
//
//  Created by 황득연 on 10/17/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct BookmarkEditItemView: View {

  static let height: CGFloat = 62

  @Bindable var bookmark: Bookmark

  let onTapDelete: (Bookmark) -> Void

  var body: some View {
    content
  }
}

private extension BookmarkEditItemView {
  var content: some View {
    HStack {
      TextField("", text: $bookmark.title)
        .font(.spoqaHans(size: 15, weight: .bold))
        .foregroundStyle(Color.textPrimary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .underline()
        .submitLabel(.done)

      HStack(spacing: 2) {
        PlainButton {
          onTapDelete(bookmark)
        } label: {
          Image.icDailyTrash
        }

        Image.icDailyReorder
      }
    }
    .padding(.horizontal, 16)
    .frame(height: Self.height)
    .background(
      RoundedRectangle(cornerRadius: 12)
        .fill(Color.backgroundSecondary)
        .frame(height: 52)
    )
    .padding(.horizontal, 16)
  }
}

