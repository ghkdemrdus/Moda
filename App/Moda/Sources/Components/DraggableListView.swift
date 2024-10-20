//
//  DraggableListView.swift
//  Moda
//
//  Created by 황득연 on 10/19/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI


struct DraggableListView<Item: Identifiable, ItemView: View>: View {
  @Binding var items: [Item]
  let itemHeight: CGFloat
  let itemView: (Item) -> ItemView

  @State private var scrollOffset: CGFloat = 0
  @State private var scrollHeight: CGFloat = 0

  @State private var draggingItem: Item?
  @State private var draggingIndex: Int?
  @State private var dragOffset: CGFloat = 0
  @State private var isDragging: Bool = false

  private let feedback = UIImpactFeedbackGenerator(style: .light)

  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
          itemView(item)
            .opacity(draggingItem?.id == item.id ? 0 : 1)
            .overlay(alignment: .trailing) {
              DragGestureOverlay(
                index: index,
                item: item,
                isDragging: $isDragging,
                startDragging: startDragging,
                updateDragging: updateDragging,
                endDragging: endDragging
              )
              .frame(size: itemHeight)
            }
        }
      }
      .onChangeSize {
        scrollHeight = min($0.height, UIScreen.heightExceptSafeArea - 300)
      }
      .onChangePosition {
        scrollOffset = $0
      }
    }
    .frame(maxHeight: scrollHeight)
    .coordinateSpace(name: "ScrollView")
    .scrollDisabled(isDragging)
    .scrollBounceBehavior(.basedOnSize)
    .overlay(alignment: .top) {
      if let draggingItem = draggingItem {
        itemView(draggingItem)
          .offset(y: dragOffset + scrollOffset)
          .zIndex(1)
      }
    }
  }
}

struct DragGestureOverlay<Item: Identifiable>: View {
  let index: Int
  let item: Item
  @Binding var isDragging: Bool

  let startDragging: (Int, Item) -> Void
  let updateDragging: (DragGesture.Value) -> Void
  let endDragging: () -> Void

  var body: some View {
    Rectangle()
      .fill(Color.clear)
      .contentShape(Rectangle())
      .highPriorityGesture(
        DragGesture(minimumDistance: 0)
          .onChanged { value in
            if !isDragging {
              startDragging(index, item)
            }
            updateDragging(value)
          }
          .onEnded { _ in
            if isDragging {
              endDragging()
            }
          }
      )
  }
}

extension DraggableListView {
  private func startDragging(index: Int, item: Item) {
    draggingItem = item
    draggingIndex = index
    dragOffset = CGFloat(index) * itemHeight
    isDragging = true
  }

  private func updateDragging(_ value: DragGesture.Value) {
    guard let draggingIndex = draggingIndex else { return }

    dragOffset = CGFloat(draggingIndex) * itemHeight + value.translation.height

    // 드래그 오프셋 제한
    dragOffset = limitedDragOffset()

    // 새로운 인덱스 계산
    var newIndex = Int((dragOffset + itemHeight / 2) / itemHeight)
    newIndex = max(0, min(items.count - 1, newIndex))

    if newIndex != draggingIndex {
      items.move(fromOffsets: IndexSet(integer: draggingIndex), toOffset: newIndex > draggingIndex ? newIndex + 1 : newIndex)
      self.draggingIndex = newIndex
      feedback.impactOccurred()
    }
  }

  private func endDragging() {
    draggingItem = nil
    draggingIndex = nil
    dragOffset = 0
    isDragging = false
  }

  private func limitedDragOffset() -> CGFloat {
    let minOffset: CGFloat = 0
    let maxOffset: CGFloat = CGFloat(items.count - 1) * itemHeight
    return min(max(dragOffset, minOffset), maxOffset)
  }
}
