//
//  VersionNoticeAlertModifier.swift
//  ModaCore
//
//  Created by 황득연 on 10/1/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct VersionNoticeAlertModifier: ViewModifier {
  @ObservedObject var manager = NoticeManager.shared

  func body(content: Content) -> some View {
    ZStack {
      content

      ZStack {
        Color.black
          .ignoresSafeArea()
          .opacity(manager.isPresented ? 0.5 : 0)
          .onTapGesture {}

        if manager.isPresented {
          VersionNoticeAlertView(
            onClose: {
              manager.dismiss()
            },
            content: {
              AnyView(manager.content)
            }
          )
          .zIndex(1)
        }
      }
      .animation(.spring(duration: 0.4), value: manager.isPresented)
      .ignoresSafeArea(edges: .bottom)
    }
  }
}

public extension View {
  func versionNoticeAlert() -> some View {
    modifier(VersionNoticeAlertModifier())
  }
}
