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
      if !entry.monthlyTodos.isEmpty {
        VStack(alignment: .leading, spacing: 12) {
          Text("먼쓸리 투두")
            .font(.spoqaHans(size: 19, weight: .bold))
            .foregroundColor(ModaWidgetExtensionAsset.titleText.swiftUIColor)

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
        VStack(alignment: .leading, spacing: 12) {
          Text("데일리 투두")
            .font(.spoqaHans(size: 19, weight: .bold))
            .foregroundColor(ModaWidgetExtensionAsset.titleText.swiftUIColor)

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
    .widgetBackground(ModaWidgetExtensionAsset.monthlyBg.swiftUIColor)
  }
}
