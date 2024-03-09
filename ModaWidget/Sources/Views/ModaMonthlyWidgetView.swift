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
      VStack {
        Text("먼쓸리\n투두")
          .font(.spoqaHans(size: 19, weight: .bold))
          .foregroundColor(ModaWidgetExtensionAsset.titleText.swiftUIColor)

        Text(Date().toHM())
      }

      VStack(alignment: .leading) {
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

        Spacer()
      }
    }
    .widgetBackground(ModaWidgetExtensionAsset.monthlyBg.swiftUIColor)
  }
}
