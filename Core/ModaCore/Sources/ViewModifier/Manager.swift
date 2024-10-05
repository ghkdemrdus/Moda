//
//  Manager.swift
//  ModaCore
//
//  Created by 황득연 on 10/1/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

@MainActor
public final class NoticeManager: ObservableObject {
  public static let shared = NoticeManager()
  private init() {}

  @Published public private(set) var isPresented: Bool = false
  public var content: AnyView?
  private var continuation: CheckedContinuation<Void, Never>?

  public func show(@ViewBuilder content: () -> AnyView) async {
    self.content = content()
    self.isPresented = true
    return await withCheckedContinuation { continuation in
      self.continuation = continuation
    }
  }

  public func dismiss() {
    isPresented = false
    continuation?.resume()
    continuation = nil
  }
}
