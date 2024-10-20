//
//  BottomSheet.swift
//  Moda
//
//  Created by 황득연 on 10/20/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import ComposableArchitecture

extension DependencyValues {
  var bottomSheet: BottomSheetClient {
    get { self[BottomSheetClient.self] }
    set { self[BottomSheetClient.self] = newValue }
  }
}

struct BottomSheetClient {
  var show: @Sendable (BottomSheetConfiguration, _ onConfirm: (() -> Void)?) async -> Void
}

extension BottomSheetClient: DependencyKey {
  static let liveValue: Self = {
    Self(
      show: {
        await BottomSheetManager.shared.show(config: $0, onConfirm: $1)
      }
    )
  }()
}
