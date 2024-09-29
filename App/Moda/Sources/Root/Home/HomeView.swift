//
//  HomeView.swift
//  ModaData
//
//  Created by 황득연 on 3/18/24.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: Home.self)
struct HomeView: View {

  @Bindable var store: StoreOf<Home>

  @State private var isMonthlyFolded = true
  @State private var isMonthlyEditing = false
  @State private var isDailyEditing = false
  @State private var isDeleteTodoBottomSheetPresented = false
  @State private var isDelayTodoBottomSheetPresented = false
  @State private var deletingTodo: Todo?

  @Namespace private var monthlyAnimationNamespace
  @Namespace private var dailyAnimationNamespace

  var body: some View {
    content
      .animation(.spring, value: isMonthlyEditing)
      .animation(.spring, value: isDailyEditing)
      .animation(.spring, value: isDeleteTodoBottomSheetPresented)
  }
}

// MARK: - UI Components

private extension HomeView {
  @ViewBuilder var content: some View {
    VStack(spacing: 0) {
      HomeMonthSelectorView(
        currentDate: store.currentDate.date,
        onChangeMonth: {
          send(.monthChanged($0))
        }
      )
      .blur(radius: isMonthlyEditing || isDailyEditing ? 1.2 : 0)

      HomeDateSelectorView(dates: store.dates, currentDate: $store.currentDate)
        .padding(.top, 12)
        .blur(radius: isMonthlyEditing || isDailyEditing ? 1.2 : 0)

      ScrollView {
        LazyVStack(spacing: 24) {
          HomeMonthlyTodoView(
            isFolded: $isMonthlyFolded,
            todos: $store.monthlyTodos,
            onTapEdit: {
              isMonthlyEditing = true
            }
          )
          .opacity(isMonthlyEditing || isDailyEditing ? 0 : 1)
          .matchedGeometryEffect(id: "Monthly", in: monthlyAnimationNamespace, anchor: .top)

          HomeDailyTodoView(
            todos: $store.dailyTodos,
            onTapEdit: {
              isDailyEditing = true
            }
          )
          .opacity(isMonthlyEditing || isDailyEditing ? 0 : 1)
          .matchedGeometryEffect(id: "Daily", in: dailyAnimationNamespace, anchor: .top)
        }
        .padding(.vertical, 16)
        .animation(.spring, value: isMonthlyFolded)
      }

      if store.editingTodo == nil {
        HomeInputView(onTapAdd: {
          send(.todoAdded($0, $1))
        })
        .blur(radius: isMonthlyEditing || isDailyEditing ? 1.2 : 0)
      }
    }
    .background(Color.backgroundPrimary)
    .overlay(if: isMonthlyEditing) {
      VStack(spacing: 0) {
        Color.clear.frame(height: 132)

        HomeMonthlyTodoEditView(
          todos: $store.monthlyTodos,
          onTapDone: {
            isMonthlyEditing = false
          },
          onTapDelete: {
            deletingTodo = $0
            isDeleteTodoBottomSheetPresented = true
          },
          onTapDelay: {
            deletingTodo = $0
            isDelayTodoBottomSheetPresented = true
          }
        )
        .matchedGeometryEffect(id: "Monthly", in: monthlyAnimationNamespace, anchor: .top)

        Spacer()
      }
      .background {
        Color.backgroundPrimary.opacity(0.5)
          .ignoresSafeArea()
          .onTapGesture {
            isMonthlyEditing = false
          }
      }
    }
    .overlay(if: isDailyEditing) {
      VStack(spacing: 0) {
        Color.clear.frame(height: 132)

        HomeDailyTodoEditView(
          todos: $store.dailyTodos,
          onTapDone: {
            isDailyEditing = false
          },
          onTapDelete: {
            deletingTodo = $0
            isDeleteTodoBottomSheetPresented = true
          },
          onTapDelay: {
            deletingTodo = $0
            isDelayTodoBottomSheetPresented = true
          }
        )
        .matchedGeometryEffect(id: "Daily", in: dailyAnimationNamespace, anchor: .top)

        Spacer()
      }
      .background {
        Color.backgroundPrimary.opacity(0.5)
          .ignoresSafeArea()
          .onTapGesture {
            isDailyEditing = false
          }
      }
    }
    .overlay {
      HomeDeleteTodoBottomSheet(
        isPresented: $isDeleteTodoBottomSheetPresented,
        todo: deletingTodo,
        onTapDelete: { 
          send(.todoDeleted($0))
        }
      )
      .ignoresSafeArea()
    }
    .overlay {
      HomeDelayTodoBottomSheet(
        isPresented: $isDelayTodoBottomSheetPresented,
        todo: deletingTodo,
        onTapDelete: {
          send(.todoDeleted($0))
        }
      )
      .ignoresSafeArea()
    }
  }
}

#Preview {
  HomeView(
    store: .init(initialState: Home.State()) {
      Home()
    }
  )
  .loadCustomFonts()
}
