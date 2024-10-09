//
//  ModaToastManager.swift
//  Moda
//
//  Created by 황득연 on 10/6/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture

@MainActor
public final class ModaToastManager: ObservableObject {

  public enum BottomType: Equatable, Hashable {
    case delayTodo
    case deleteTodo
    case doneTodo
    case custom(String)

    var icon: Image? {
      switch self {
      case .delayTodo: return .icCheck
      case .deleteTodo: return .icDelete
      case .doneTodo: return .icClear
      case .custom: return nil
      }
    }

    var text: String {
      switch self {
      case .delayTodo: return "미루기 완료!"
      case .deleteTodo: return "삭제 완료!"
      case .doneTodo: return "참 잘했어요!"
      case let .custom(text): return text
      }
    }
  }

  public static let shared = ModaToastManager()
  private init() {}

  @Published public private(set) var isPresented: Bool = false
  public private(set) var type: BottomType = .custom("Toast")

  private var toastQueue: [BottomType] = []
  private var hideTask: Task<Void, Never>?

  public func show(_ type: BottomType) {
    if isPresented {
      if self.type == type {
        // 같은 타입의 토스트: 숨김 타이머 재설정
        hideTask?.cancel()
        startHideTask()
      } else {
        // 다른 타입의 토스트: 큐에 추가
        toastQueue.append(type)
      }
    } else {
      // 토스트가 표시되지 않은 경우: 즉시 표시
      self.type = type
      isPresented = true
      startHideTask()
    }
  }

  private func startHideTask() {
    hideTask?.cancel()
    hideTask = Task { [weak self] in
      do {
        try await Task.sleep(for: .seconds(2))
        guard let self = self else { return }
        self.isPresented = false
        self.hideTask = nil
        self.processNextToast()
      } catch {

      }
    }
  }

  private func processNextToast() {
    if !toastQueue.isEmpty {
      let nextType = toastQueue.removeFirst()
      self.type = nextType
      isPresented = true
      startHideTask()
    }
  }
}

extension DependencyValues {
  var toastManager: ModaToastManager {
    get { self[ModaToastManager.self] }
    set { self[ModaToastManager.self] = newValue }
  }
}

extension ModaToastManager: DependencyKey {
  public static let liveValue = ModaToastManager()
}
