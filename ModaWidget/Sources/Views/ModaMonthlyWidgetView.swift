//
//  ModaMonthlyWidgetView.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/9/24.
//

import SwiftUI
import WidgetKit

struct ModaMonthlyWidgetView : View {
  var entry: ModaMonthlyProvider.Entry

  var body: some View {
    HStack(alignment: .top, spacing: 12) {
      VStack(alignment: .leading) {
        Text("먼쓸리\n투두")
          .font(.spoqaHans(size: 19, weight: .bold))
          .foregroundColor(ModaWidgetExtensionAsset.titleText.swiftUIColor)

        Spacer()

        ModaCountView(totalCount: entry.totalCount, doneCount: entry.doneCount)
      }

      VStack {
        if !entry.monthlyTodos.isEmpty {
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
        } else {
          if isEmpty {
            ModaWidgetExtensionAsset.imgWidgetMonthlyEmpty.swiftUIImage
          } else {
            ModaWidgetExtensionAsset.imgWidgetMonthlyDone.swiftUIImage
          }

          Text(isEmpty ? "아직 이번 달에 해야할 일이 없어요\n새롭게 추가해볼까요?" : "이번 달의 해야할 일을 다 끝냈어요!\nNicely done~")
            .font(.spoqaHans(size: 13))
            .foregroundColor(ModaWidgetExtensionAsset.monthlyEmptyText.swiftUIColor)
            .multilineTextAlignment(.center)
        }

        Spacer()
      }
      .frame(maxWidth: .infinity)

      if entry.monthlyTodos.isEmpty {
        Spacer().frame(width: 12)
      }
    }
    .widgetBackground(ModaWidgetExtensionAsset.monthlyBg.swiftUIColor)
  }

  private var isEmpty: Bool {
    entry.totalCount == 0
  }
}
