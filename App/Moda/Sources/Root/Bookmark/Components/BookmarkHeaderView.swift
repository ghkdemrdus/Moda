//
//  BookmarkHeaderView.swift
//  Moda
//
//  Created by 황득연 on 10/13/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct BookmarkHeaderView: View {

  let bookmarkCount: Int
  let onTapEdit: () -> Void

  var body: some View {
    content
  }
}

// MARK: - Content

private extension BookmarkHeaderView {
  @ViewBuilder var content: some View {
    HStack {
      HStack(spacing: 6) {
        Text("북마크")
          .font(.spoqaHans(size: 16, weight: .bold))
          .foregroundStyle(Color.textPrimary)

        if bookmarkCount > 0 {
          Text("\(bookmarkCount)")
            .font(.spoqaHans(size: 10, weight: .bold))
            .foregroundStyle(.white)
            .frame(size: 16)
            .padding(.top, 0.5)
            .background(
              Circle()
                .fill(Color.brandStrong)
            )
        }
      }

      Spacer()

      PlainButton {
        onTapEdit()
      } label: {
        Image.icFolderEdit
          .frame(size: 32)
      }
    }
    .frame(height: 40)
    .padding(.leading, 20)
    .padding(.trailing, 16)
  }
}

// MARK: - Preview

#Preview {
  BookmarkHeaderView(bookmarkCount: 3, onTapEdit: {})
}
