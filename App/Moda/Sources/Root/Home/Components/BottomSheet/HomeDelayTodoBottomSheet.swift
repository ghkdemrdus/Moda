//
//  HomeDelayTodoBottomSheet.swift
//  Moda
//
//  Created by 황득연 on 9/29/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HomeDelayTodoBottomSheet: View {

  enum Option: CaseIterable {
    case tomorrow
    case specificDate

    var title: String {
      switch self {
      case .tomorrow: "내일로"
      case .specificDate: "날짜 지정"
      }
    }
  }

  @State var selectedOption: Option = .tomorrow
  @State var isDatePickerShown: Bool = false
  @Binding var isPresented: Bool

  let todo: Todo?

  let onTapDelete: (Todo) -> Void

  var body: some View {
    ZStack(alignment: .bottom) {
      Color.black
        .opacity(isPresented ? 0.5 : 0)
        .onTapGesture {
          isPresented = false
        }

      if isPresented {
        VStack(spacing: 0) {
          HStack {
            Text("언제로 미룰까요?")
              .font(.spoqaHans(size: 18, weight: .bold))
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          .padding(.vertical, 8)
          .padding(.horizontal, 24)

          VStack(spacing: 0) {
            ForEach(Option.allCases, id: \.self) { option in
              HStack(spacing: 10) {
                selectedOption == option
                ? Image.icCheckActive
                : Image.icCheckInactive

                Text(option.title)
                  .font(.spoqaHans(size: 17))
                  .foregroundStyle(Color.textPrimary)

                Spacer()
              }
              .padding(.vertical, 14)
              .padding(.horizontal, 24)
              .contentTouchable()
              .onTapGesture {
                selectedOption = option
                isDatePickerShown = option == .specificDate
              }
            }
          }
          .padding(.top, 12)

          if isDatePickerShown {
            DatePicker(
              "",
              selection: $selectedDate,
              displayedComponents: [.date]
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .clipped()
          }

          PlainButton(
            action: {
              guard let todo else { return }
              onTapDelete(todo)
              isPresented = false
            },
            label: {
              Text("좋아요!")
                .font(.spoqaHans(size: 16, weight: .bold))
                .foregroundStyle(.white)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(
                  RoundedRectangle(cornerRadius: 12)
                    .fill(Color.brandStrong)
                )
            }
          )
          .padding(.top, 12)
          .padding(.horizontal, 24)
        }
        .padding(.vertical, 16)
        .padding(.bottom, UIApplication.shared.safeAreaBottomHeight)
        .background(
          Color.backgroundSecondary
            .clipShape(.rect(topLeadingRadius: 16, topTrailingRadius: 16))
        )
        .zIndex(1)
        .transition(.move(edge: .bottom))
      }
    }
    .zIndex(2)
    .animation(.spring, value: isPresented)
    .animation(.spring, value: isDatePickerShown)
  }

  @State private var selectedDate = Date()

  func formattedDate(date: Date) -> String {
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy년 MM월 dd일"
          return formatter.string(from: date)
      }
}
