//
//  HomeMonthlyTodoEditView.swift
//  Moda
//
//  Created by 황득연 on 9/28/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeMonthlyTodoEditView: View {

  let prevTodos: [HomeTodo]

  @State private var height: CGFloat = 0
  @State private var offsetY: CGFloat = 0

  @State private var todos: [HomeTodo] = []
  @State private var draggingTodo: HomeTodo?
  @State private var draggingIdx: Int?
  @State private var dragOffset: CGFloat = 0
  @State private var isDragging: Bool = false

  private let feedback = UIImpactFeedbackGenerator(style: .light)

  let onTapDone: () -> Void
  let onTapDelete: (HomeTodo) -> Void
  let onTapDelay: (HomeTodo) -> Void
  let onReorder: ([HomeTodo]) -> Void

  var body: some View {
    content
      .onChange(of: prevTodos, initial: true) {
        todos = $1
        if $1.count == 0 {
          onTapDone()
        }
      }
  }
}

private extension HomeMonthlyTodoEditView {
  var content: some View {
    ZStack(alignment: .top) {
      VStack(spacing: 6) {
        HStack {
          Text("먼쓸리 투두")
            .font(.spoqaHans(size: 19, weight: .bold))
            .foregroundStyle(Color.textPrimary)
            .frame(maxWidth: .infinity, alignment: .leading)

          Spacer()

          PlainButton(
            action: {
              onTapDone()
            },
            label: {
              Text("완료")
                .font(.spoqaHans(size: 14, weight: .bold))
                .foregroundStyle(Color.iconSecondary)
            }
          )
        }
        .padding(.horizontal, 16)

        ScrollView {
          VStack(spacing: 0) {
            ForEach(Array(todos.enumerated()), id: \.element.id) { idx, todo in
              HomeMonthlyTodoEditItemView(
                idx: idx,
                todo: todo,
                isDragging: $isDragging,
                onTapDelete: onTapDelete,
                onTapDelay: onTapDelay,
                startDragging: startDragging,
                updateDragging: updateDragging,
                endDragging: endDragging
              )
              .opacity(draggingTodo?.id == todo.id ? 0 : 1)
            }
          }
          .onChangeSize {
            height = min($0.height, UIScreen.heightExceptSafeArea - 240)
          }
          .onChangePosition {
            offsetY = $0
          }
        }
        .frame(maxHeight: height)
        .coordinateSpace(name: "ScrollView")
        .scrollDisabled(isDragging)
        .scrollBounceBehavior(.basedOnSize)
        .overlay(alignment: .top) {
          if let draggingItem = draggingTodo {
            HomeMonthlyTodoEditItemView(
              idx: -1,
              todo: draggingItem,
              isDragging: .constant(false),
              onTapDelete: { _ in },
              onTapDelay: { _ in },
              startDragging: { _, _ in },
              updateDragging: { _ in },
              endDragging: {}
            )
            .offset(y: min(limitedDragOffset() + offsetY, UIScreen.heightExceptSafeArea - 240))
            .zIndex(1)
          }
        }
      }
      .padding(.top, 12)
      .padding(.bottom, 6)
      .background(
        RoundedRectangle(cornerRadius: 16)
          .fill(Color.backgroundBrand)
      )
      .padding(.horizontal, 16)
    }
  }
}

private extension HomeMonthlyTodoEditView {
  func startDragging(idx: Int, todo: HomeTodo) {
    draggingTodo = todo
    draggingIdx = idx
    dragOffset = CGFloat(idx) * HomeMonthlyTodoEditItemView.height
    isDragging = true
  }

  func updateDragging(value: DragGesture.Value) {
    guard let draggingIdx = draggingIdx else { return }

    dragOffset = CGFloat(draggingIdx) * HomeMonthlyTodoEditItemView.height + value.translation.height

    // 드래그 오프셋을 제한하여 리스트 영역을 벗어나지 않도록 합니다.
    dragOffset = limitedDragOffset()

    // 새로운 인덱스 계산
    var newIndex = Int((dragOffset + HomeMonthlyTodoEditItemView.height / 2) / HomeMonthlyTodoEditItemView.height)
    newIndex = max(0, min(todos.count - 1, newIndex))

    if newIndex != draggingIdx {
      todos.move(fromOffsets: IndexSet(integer: draggingIdx), toOffset: newIndex > draggingIdx ? newIndex + 1 : newIndex)
      self.draggingIdx = newIndex
      feedback.impactOccurred()
    }
  }

  func endDragging() {
    draggingTodo = nil
    draggingIdx = nil
    dragOffset = 0
    isDragging = false
    onReorder(todos)
  }

  // 드래그 오프셋을 제한하는 함수
  func limitedDragOffset() -> CGFloat {
    let minOffset: CGFloat = 0
    let maxOffset: CGFloat = CGFloat(todos.count - 1) * HomeMonthlyTodoEditItemView.height
    return min(max(dragOffset, minOffset), maxOffset)
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  @Previewable @State var todos: [HomeTodo] = [
    .init(id: "1", order: 1, content: "Todo1", isDone: true, category: .monthly),
    .init(id: "2", order: 2, content: "Todo2", isDone: true, category: .monthly),
    .init(id: "3", order: 3, content: "Todo3", isDone: false, category: .monthly),
    .init(id: "4", order: 4, content: "Todo4", isDone: false, category: .monthly),
    .init(id: "5", order: 5, content: "Todo5Todo5Todo5Todo5Todo5Todo5Todo5Todo5Todo5Todo5", isDone: false, category: .monthly)
  ]

  HomeMonthlyTodoEditView(
    prevTodos: todos,
    onTapDone: {},
    onTapDelete: { _ in },
    onTapDelay: { _ in },
    onReorder: { _ in }
  )
  .loadCustomFonts()
}

