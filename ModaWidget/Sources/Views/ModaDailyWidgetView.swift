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
      Text("데일리\n투두")
        .font(.spoqaHans(size: 19, weight: .bold))
        .foregroundColor(ModaWidgetExtensionAsset.titleText.swiftUIColor)

      VStack(alignment: .leading) {
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
      }
    }
    .widgetBackground(Color.white)
  }
}


