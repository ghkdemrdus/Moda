//
//  SettingView.swift
//  Moda
//
//  Created by 황득연 on 10/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: SettingCore.self)

struct SettingView: View {

  @Bindable var store: StoreOf<SettingCore>

  var body: some View {
    content
  }
}

// MARK: - Content

private extension SettingView {
  var content: some View {
    VStack {
      Text("Setting")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.yellow)
  }
}
