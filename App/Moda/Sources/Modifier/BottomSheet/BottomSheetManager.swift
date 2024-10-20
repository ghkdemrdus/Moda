//
//  BottomSheetManager.swift
//  Moda
//
//  Created by 황득연 on 10/19/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture

public typealias BottomSheetConfiguration = BottomSheetManager.Configuration

@MainActor
public final class BottomSheetManager: ObservableObject {

  public struct Configuration {
    let buttonText: String
    let content: AnyView

    init(buttonText: String, @ViewBuilder content: @escaping () -> some View) {
      self.buttonText = buttonText
      self.content = AnyView(content())
    }
  }

  public static let shared = BottomSheetManager()
  private init() {}

  @Published public private(set) var isPresented: Bool = false
  public private(set) var config: Configuration = .init(buttonText: "", content: { EmptyView() })
  public private(set) var onConfirm: (() -> Void)?
  private var continuation: CheckedContinuation<Void, Never>?

  public func show(config: Configuration, onConfirm: (() -> Void)? = nil) async {
    self.config = config
    self.onConfirm = onConfirm
    isPresented = true
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

// MARK: - Configurations

extension BottomSheetConfiguration {
  static func deleteTodo(content: String) -> BottomSheetConfiguration {
    .init(buttonText: "좋아요") {
      HStack(spacing: 10) {
        Image.icDelete

        VStack(alignment: .leading, spacing: 0) {
          Text("'\(content)'")
            .lineLimit(1)
          Text("투두를 삭제할까요?")
        }
        .font(.spoqaHans(size: 17))
        .foregroundStyle(Color.textPrimary)

        Spacer()
      }
      .padding(.vertical, 5)
    }
  }
}
