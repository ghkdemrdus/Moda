//
//  BottomSheetModifier.swift
//  Moda
//
//  Created by 황득연 on 10/19/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct BottomSheetModifier: ViewModifier {

  @ObservedObject var manager = BottomSheetManager.shared

  func body(content: Content) -> some View {
    content
      .overlay {
        ZStack {
          Color.black
            .opacity(manager.isPresented ? 0.5 : 0)
            .onTapGesture {
              manager.dismiss()
            }

          VStack {
            Spacer()
            if manager.isPresented {
              BottomSheetView(
                config: manager.config,
                onTapConfirm: {
                  manager.onConfirm?()
                  manager.dismiss()
                }
              )
            }
          }
        }
        .ignoresSafeArea()
      }
      .animation(.spring(duration: 0.4), value: manager.isPresented)
  }
}

public extension View {
  func globalBottomSheet() -> some View {
    modifier(BottomSheetModifier())
  }
}
