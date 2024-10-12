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

public typealias ToastType = ModaToastManager.`Type`

@MainActor
public final class ModaToastManager: ObservableObject {

  public enum `Type`: Hashable {
    case delayTodo
    case deleteTodo
    case doneTodo(String)
    case custom(String)
  }

  public static let shared = ModaToastManager()
  private init() {}

  @Published public private(set) var isPresented: Bool = false
  @Published public private(set) var type: `Type` = .custom("Toast")

  private var toastQueue: [`Type`] = []
  private var hideTask: Task<Void, Never>?

  public func show(_ type: `Type`) {
    if isPresented {
      if self.type == type {
        // 같은 타입의 토스트: 숨김 타이머 재설정
        restartCountdown()
      } else {
        self.type = type
        restartCountdown()
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
      } catch {}
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

  public func dismissImmediately() {
    hideTask?.cancel()
    isPresented = false
    hideTask = nil
    processNextToast()
  }

  public func cancelCountdown() {
    hideTask?.cancel()
  }

  public func restartCountdown() {
    hideTask?.cancel()
    startHideTask()
  }
}

// MARK: - `ModaToastManager.BottomType` Extension

extension ModaToastManager.`Type` {
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
    case let .doneTodo(text): return text
    case let .custom(text): return text
    }
  }

  var isDone: Bool {
    switch self {
    case .doneTodo: return true
    default: return false
    }
  }

  static var doneText: String {
    doneTexts.randomElement()!
  }

  static var doneTexts: [String] {
    [
      "참 잘했어요!✨",
      "고생 많았어요👍",
      "멋져요~💪",
      "대단해요!🌟",
      "한 걸음 더 나아갔네요!👏",
      "지금처럼 천천히 이어가면 돼요🌸",
      "하나씩 완성해가고 있어요💫",
      "힘내서 잘 해냈어요!🔥",
      "오늘도 성실하게 해냈어요🌿",
      "오늘도 작은 진전을 이루었어요🌟",
      "한 걸음씩 앞으로 가고 있어요🚶‍♂️",
      "조금씩 성취를 쌓아가고 있군요📚",
      "꾸준함이 멋져요😊",
      "작은 성취가 쌓이고 있어요🌱",
      "오늘 할 일을 깔끔히 처리했어요✨",
      "한 가지 더 완료했네요✨",
      "정말 대단한 성취예요!🌟",
      "당신의 속도로 충분해요🐢",
      "작은 성취가 큰 변화를 만들어요!🌿",
      "좋은 흐름이에요🌊",
      "한 걸음씩 나아가고 있어요!✨",
      "힘든 걸 해냈어요, 정말 멋져요!🔥",
      "잘 해내고 있어요, 정말 훌륭해요!👏",
      "꾸준한 노력, 정말 멋져요!✨",
      "하나씩 이뤄가고 있어요!🏅",
      "차근차근 잘 하고 있어요!🌿",
      "할 일을 하나 더 끝냈어요📝",
      "작은 걸음들이 모여 큰 성취가 될 거예요.🌱"
    ]
  }
}

extension ModaToastManager.`Type`: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    switch (lhs, rhs) {
    case (.delayTodo, .delayTodo):
      return true
    case (.deleteTodo, .deleteTodo):
      return true
    case (let .doneTodo(ls), let .doneTodo(rs)):
      return ls == rs
    case (let .custom(ls), let .custom(rs)):
      return ls == rs
    default:
      return false
    }
  }
}

// MARK: - Dependency

extension DependencyValues {
  var toastManager: ModaToastManager {
    get { self[ModaToastManager.self] }
    set { self[ModaToastManager.self] = newValue }
  }
}

extension ModaToastManager: DependencyKey {
  public static let liveValue = ModaToastManager()
}
