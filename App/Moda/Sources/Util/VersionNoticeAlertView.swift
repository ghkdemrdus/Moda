//
//  VersionNoticeAlertView.swift
//  ModaCore
//
//  Created by 황득연 on 10/1/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct VersionNoticeAlertView: View {

  let title: String?
  let description: String?
  let content: AnyView

  let onClose: () -> Void

  init(
    title: String? = "업데이트 안내사항",
    description: String? = "다른 기능들도 얼른 출시할테니 기다려주세요!",
    onClose: @escaping () -> Void,
    @ViewBuilder content: () -> AnyView
  ) {
    self.title = title
    self.description = description
    self.onClose = onClose
    self.content = content()
  }

  var body: some View {
    VStack {
      HStack {
        if let title {
          Text(title)
            .font(.spoqaHans(size: 18, weight: .bold))
            .foregroundStyle(Color.textPrimary)
        }

        Spacer()

        PlainButton(
          action: {
            onClose()
          },
          label: {
            Image.icClose
          }
        )
      }
      .padding(.bottom, 24)

      content

      if let description {
        HStack(spacing: 4) {
          Image.icRepair

          Text(description)
            .font(.spoqaHans(size: 13))
            .foregroundStyle(Color.textSecondary)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 13)
        .background(
          RoundedRectangle(cornerRadius: 12)
            .fill(Color.brandTertiary)
        )
        .padding(.top, 16)
      }

      PlainButton(
        action: {
//          onTapConfirm()
        },
        label: {
          Text("좋아요!")
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .background(
              RoundedRectangle(cornerRadius: 12)
                .fill(Color.brandStrong)
            )
        }
      )
      .padding(.top, 24)
    }
    .padding(.top, 24)
    .padding(.bottom, 16)
    .padding(.horizontal, 16)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.backgroundPrimary)
    )
    .padding(.horizontal, 35)
  }
}

#Preview {
//  VersionNoticeAlertView()
}
