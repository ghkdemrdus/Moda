//
//  Manager.swift
//  ModaCore
//
//  Created by 황득연 on 10/1/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

// MARK: - Configuration

public struct BottomMenuConfiguration {
  let confirmTitle: String
  var cancelTitle: String = "취소"
  let confirmAction: () async -> Void
}

// MARK: - BottomMenuManager

@MainActor
public final class BottomMenuManager: ObservableObject {
  public static let shared = BottomMenuManager()
  private init() {}

  @Published private(set) var isPresented: Bool = false
  public var content: AnyView?
  private var continuation: CheckedContinuation<Void, Never>?

  func show(@ViewBuilder content: () -> AnyView) async {
    self.isPresented = true
    self.content = content()
    return await withCheckedContinuation { continuation in
      self.continuation = continuation
    }
  }

  func dismiss() {
    isPresented = false
    continuation?.resume()
    continuation = nil
  }
}
