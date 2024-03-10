//
//  ModaWidgetView.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 2/27/24.
//

import SwiftUI
import WidgetKit

struct ModaDailyWidgetView : View {
  var entry: ModaDailyProvider.Entry

  var body: some View {
    HStack(alignment: .top, spacing: 12) {
      VStack(alignment: .leading) {
        Text("데일리\n투두")
          .font(.spoqaHans(size: 19, weight: .bold))
          .foregroundColor(ModaWidgetExtensionAsset.titleText.swiftUIColor)

        Spacer()

        ModaCountView(totalCount: entry.totalCount, doneCount: entry.doneCount)
      }

      VStack {
        if !entry.dailyTodos.isEmpty {
          ForEach(entry.dailyTodos, id: \.id) { todo in
            HStack(alignment: .center, spacing: 8) {
              ModaWidgetExtensionAsset.imgHomeDailyDoInactive.swiftUIImage
                .frame(width: 24, height: 24)

              Text(todo.content)
                .font(.spoqaHans(size: 15))
                .foregroundColor(ModaWidgetExtensionAsset.todoText.swiftUIColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 24)
            .frame(maxWidth: .infinity)
          }

          Spacer()
        } else {
          if isEmpty {
            ModaWidgetExtensionAsset.imgWidgetDailyEmpty.swiftUIImage
          } else {
            ModaWidgetExtensionAsset.imgWidgetMonthlyDone.swiftUIImage
          }

          Text(isEmpty ? "아직 오늘 해야할 일이 없어요\n새롭게 추가해볼까요?" : "오늘 해야할 일을 다 끝냈어요!\nNicely done~")
            .font(.spoqaHans(size: 13))
            .foregroundColor(ModaWidgetExtensionAsset.titleText.swiftUIColor)
            .multilineTextAlignment(.center)
        }
      }
      .frame(maxWidth: .infinity)

      if entry.dailyTodos.isEmpty {
        Spacer().frame(width: 12)
      }
    }
    .widgetBackground(Color.white)
  }

  private var isEmpty: Bool {
    entry.totalCount == 0
  }
}


