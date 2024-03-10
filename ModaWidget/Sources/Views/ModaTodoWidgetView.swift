//
//  ModaTodoWidgetView.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/9/24.
//

import SwiftUI
import WidgetKit

struct ModaTodoWidgetView : View {
  var entry: ModaTodoProvider.Entry

  var body: some View {
    VStack(spacing: 0) {
      if entry.monthlyTodos.isEmpty && entry.dailyTodos.isEmpty {
        HStack {
          Text("먼쓸리&데일리 투두")
            .font(.spoqaHans(size: 19, weight: .bold))
            .foregroundColor(ModaWidgetExtensionAsset.titleText.swiftUIColor)

          Spacer()

          if !isEmpty {
            ModaCountView(
              totalCount: entry.monthlyTotalCount + entry.dailyTotalCount,
              doneCount: entry.monthlyDoneCount + entry.dailyDoneCount
            )
          }
        }

        VStack {
          if isEmpty {
            ModaWidgetExtensionAsset.imgWidgetTodoEmpty.swiftUIImage
          } else {
            ModaWidgetExtensionAsset.imgWidgetTodoDone.swiftUIImage
          }

          Spacer().frame(height: 8)

          Text(isEmpty ? "아직 해야할 일이 없어요\n새롭게 추가해볼까요?" : "해야할 일을 다 끝냈어요!\nNicely done~")
            .font(.spoqaHans(size: 13))
            .foregroundColor(ModaWidgetExtensionAsset.monthlyEmptyText.swiftUIColor)
            .multilineTextAlignment(.center)
        }
        .frame(maxHeight: .infinity)

        Spacer()
      } else {
        if !entry.monthlyTodos.isEmpty {
          VStack(spacing: 12) {
            HStack {
              Text("먼쓸리 투두")
                .font(.spoqaHans(size: 19, weight: .bold))
                .foregroundColor(ModaWidgetExtensionAsset.titleText.swiftUIColor)

              Spacer()

              ModaCountView(totalCount: entry.monthlyTotalCount, doneCount: entry.monthlyDoneCount)
            }

            ForEach(entry.monthlyTodos, id: \.id) { todo in
              HStack(alignment: .center, spacing: 8) {
                ModaWidgetExtensionAsset.imgHomeMonthlyDoInactive.swiftUIImage
                  .frame(width: 24, height: 24)

                Text(todo.content)
                  .font(.spoqaHans(size: 15))
                  .foregroundColor(ModaWidgetExtensionAsset.todoText.swiftUIColor)
                  .frame(maxWidth: .infinity, alignment: .leading)
              }
              .frame(height: 24)
              .frame(maxWidth: .infinity)
            }

            Spacer().frame(height: 16)
          }
        }

        if !entry.dailyTodos.isEmpty {
          VStack(spacing: 12) {
            HStack {
              Text("데일리 투두")
                .font(.spoqaHans(size: 19, weight: .bold))
                .foregroundColor(ModaWidgetExtensionAsset.titleText.swiftUIColor)

              Spacer()

              ModaCountView(totalCount: entry.dailyTotalCount, doneCount: entry.dailyDoneCount)
            }

            ForEach(entry.dailyTodos, id: \.id) { todo in
              HStack(alignment: .center, spacing: 8) {
                ModaWidgetExtensionAsset.imgHomeMonthlyDoInactive.swiftUIImage
                  .frame(width: 24, height: 24)

                Text(todo.content)
                  .font(.spoqaHans(size: 15))
                  .foregroundColor(ModaWidgetExtensionAsset.todoText.swiftUIColor)
                  .frame(maxWidth: .infinity, alignment: .leading)
              }
              .frame(height: 24)
              .frame(maxWidth: .infinity)
            }
          }
        }

        Spacer()
      }
    }
    .widgetBackground(ModaWidgetExtensionAsset.monthlyBg.swiftUIColor)
  }

    private var isEmpty: Bool {
      entry.monthlyTotalCount == 0 && entry.dailyTotalCount == 0
    }
}
