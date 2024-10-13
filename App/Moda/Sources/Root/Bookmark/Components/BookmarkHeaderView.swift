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

  var body: some View {
    content
  }
}

// MARK: - Content

private extension BookmarkHeaderView {
  @ViewBuilder var content: some View {
    HStack {
      HStack {
        Text("북마크")
          .font(.spoqaHans(size: 16, weight: .bold))
          .foregroundStyle(Color.textPrimary)

        if bookmarkCount > 0 {
          Text("\(bookmarkCount)")
            .font(.spoqaHans(size: 10, weight: .bold))
            .foregroundStyle(.white)
            .padding(.top, 3)
            .padding(.bottom, 2)
            .padding(.horizontal, 6)
            .background(
              Circle()
                .fill(Color.brandStrong)
            )
        }
      }

      Spacer()

      HStack(spacing: 0) {
        if bookmarkCount > 0 {
          PlainButton {

          } label: {
            Image.icFolderEdit
              .frame(size: 32)
          }
        }

        PlainButton {

        } label: {
          Image.icDailyAdd
            .frame(size: 32)
        }
      }
    }
    .padding(.leading, 20)
    .padding(.trailing, 16)
  }
}

// MARK: - Preview

#Preview {
  BookmarkHeaderView(bookmarkCount: 3)
}
