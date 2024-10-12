//
//  HomeAppReviewBannerView.swift
//  Moda
//
//  Created by 황득연 on 10/12/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI
import Lottie

struct HomeAppReviewBannerView: View {

  let onTapClose: () -> Void
  let onTapConfirm: () -> Void

  var body: some View {
    HStack {
      VStack(spacing: 2) {
        Text("모다 어떻게 쓰고 계세요?")
          .font(.spoqaHans(size: 16, weight: .bold))
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity, alignment: .leading)

        Text("여러분의 의견은 큰 힘이 돼요!")
          .font(.spoqaHans(size: 13, weight: .regular))
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity, alignment: .leading)
      }

      Spacer()

      Text("리뷰 남기기")
        .font(.spoqaHans(size: 13, weight: .bold))
        .foregroundStyle(.white)
        .padding(.vertical, 6)
        .padding(.horizontal, 7.5)
        .background(
          RoundedRectangle(cornerRadius: 8)
            .fill(Color.black.opacity(0.6))
        )
    }
    .padding(.vertical, 17)
    .padding(.leading, 38)
    .padding(.trailing, 12)
    .background(alignment: .bottomTrailing) {
      LottieView(animation: .homeAppReviewBanner)
        .playing(loopMode: .playOnce)
        .frame(width: 150)
        .padding(.trailing, 50)
    }
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.backgroundAppReview)
    )
    .onTapGesture {
      onTapConfirm()
    }
    .overlay(alignment: .topLeading) {
      PlainButton {
        onTapClose()
      } label: {
        Image.icAppReviewDelete
          .frame(size: 36)
          .padding(.leading, 2)
      }
    }
    .padding(.horizontal, 16)
  }
}

#Preview {
  HomeAppReviewBannerView(onTapClose: {}, onTapConfirm: {})
}
