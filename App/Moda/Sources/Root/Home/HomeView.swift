//
//  HomeView.swift
//  ModaData
//
//  Created by 황득연 on 3/18/24.
//

import SwiftUI
import ComposableArchitecture
import SwiftData

@ViewAction(for: Home.self)
struct HomeView: View {

  @Bindable var store: StoreOf<Home>

  @Environment(\.modelContext) var modelContext
  @Query var monthlyTodosList: [MonthlyTodos]
  @Query var dailyTodosList: [DailyTodos]

  @Namespace private var monthlyAnimationNamespace
  @Namespace private var dailyAnimationNamespace

  let manager = NoticeManager.shared

  var body: some View {
    content
      .versionNoticeAlert()
      .task {
        send(.onTask)
      }
      .onTapGesture {
        hideKeyboard()
      }
      .onChange(of: store.showNotice) {
        guard $1 else { return }
        Task { @MainActor in
          await manager.show {
            AnyView(noticeView)
          }
        }
      }
      .onChange(of: store.monthlyTodos) {
        updateLocalData(monthlyTodos: $1)
      }
      .onChange(of: store.dailyTodos) {
        updateLocalData(dailyTodos: $1)
      }
      .onChange(of: store.currentDate, initial: true) {
        changeTodos(oldDate: $0, newDate: $1)
      }
      .animation(.spring(duration: 0.4), value: store.isMonthlyEditing)
      .animation(.spring(duration: 0.4), value: store.isDailyEditing)
      .animation(.spring(duration: 0.4), value: store.showAppReviewBanner)
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
        },
        onTapMonth: {
          send(.monthTapped)
        }
      )

      HomeDateSelectorView(
        dates: store.dates,
        currentDate: store.currentDate,
        onTapDate: {
          send(.dateTapped($0))
        }
      )
      .padding(.top, 12)

      ScrollView {
        LazyVStack(spacing: 0) {
          if store.showAppReviewBanner {
            HomeAppReviewBannerView(
              onTapClose: {
                send(.hideAppReviewBanner)
              },
              onTapConfirm: {
                send(.reviewConfirmTapped)
              }
            )
            .padding(.bottom, 15)
          }

          HomeMonthlyTodoView(
            isFolded: $store.isMonthlyFolded,
            todos: store.monthlyTodos,
            onTapEdit: {
              hideKeyboard()
              send(.monthlyEditTapped)
            },
            onTapDone: {
              send(.monthlyTodoDoneTapped($0))
            }
          )
          .matchedGeometryEffect(id: "Monthly", in: monthlyAnimationNamespace, anchor: .top)
          .padding(.bottom, 24)

          HomeDailyTodoView(
            todos: store.dailyTodos,
            onTapEdit: {
              hideKeyboard()
              send(.dailyEditTapped)
            },
            onTapDone: {
              send(.dailyTodoDoneTapped($0))
            }
          )
          .matchedGeometryEffect(id: "Daily", in: dailyAnimationNamespace, anchor: .top)
        }
        .opacity(store.isEditing ? 0 : 1)
        .padding(.vertical, 16)
        .animation(.spring(duration: 0.4), value: store.isMonthlyFolded)
      }

      HomeInputView(
        category: store.todoCategory,
        onTapAdd: {
          send(.todoAdded($0, $1))
        },
        onTapCategory: {
          send(.todoCategoryTapped($0))
        }
      )
    }
    .background(Color.backgroundPrimary)
    .blur(radius: store.isEditing ? 1.2 : 0)
    .overlay(if: store.isMonthlyEditing) {
      VStack(spacing: 0) {
        Color.clear.frame(height: 132)

        HomeMonthlyTodoEditView(
          prevTodos: store.monthlyTodos,
          onTapDone: {
            store.isMonthlyEditing = false
          },
          onTapDelete: {
            store.editingTodo = $0
            store.isDeleteTodoBottomSheetPresented = true
          },
          onTapDelay: {
            store.editingTodo = $0
            store.isDelayTodoBottomSheetPresented = true
          },
          onReorder: {
            send(.monthlyTodosReordered($0))
          }
        )
        .matchedGeometryEffect(id: "Monthly", in: monthlyAnimationNamespace, anchor: .top)

        Spacer()
      }
      .background {
        Color.backgroundPrimary.opacity(0.5)
          .ignoresSafeArea()
          .onTapGesture {
            store.isMonthlyEditing = false
          }
      }
    }
    .overlay(if: store.isDailyEditing) {
      VStack(spacing: 0) {
        Color.clear.frame(height: 132)

        HomeDailyTodoEditView(
          prevTodos: store.dailyTodos,
          onTapDone: {
            store.isDailyEditing = false
          },
          onTapDelete: {
            store.editingTodo = $0
            store.isDeleteTodoBottomSheetPresented = true
          },
          onTapDelay: {
            store.editingTodo = $0
            store.isDelayTodoBottomSheetPresented = true
          },
          onReorder: {
            send(.dailyTodosReordered($0))
          }
        )
        .matchedGeometryEffect(id: "Daily", in: dailyAnimationNamespace, anchor: .top)

        Spacer()
      }
      .background {
        Color.backgroundPrimary.opacity(0.5)
          .ignoresSafeArea()
          .onTapGesture {
            store.isDailyEditing = false
          }
      }
    }
    .overlay {
      HomeDeleteTodoBottomSheet(
        isPresented: $store.isDeleteTodoBottomSheetPresented,
        todo: store.editingTodo,
        onTapDelete: {
          send(.todoDeleted($0))
        }
      )
      .ignoresSafeArea()
    }
    .overlay {
      HomeDelayTodoBottomSheet(
        isPresented: $store.isDelayTodoBottomSheetPresented,
        todo: store.editingTodo,
        currentDate: store.currentDate.date,
        onTapConfirm: {
          delayTodo(todo: $0, date: $1)
          send(.todoDelayed($0, $1))
        }
      )
      .ignoresSafeArea()
    }
  }

  @ViewBuilder var noticeView: some View {
    VStack(spacing: 16) {
      Image.imgNotice1
        .resizable()
        .scaledToFit()

      Image.imgNotice2
        .resizable()
        .scaledToFit()
    }
  }
}

// MARK: - Properties & Methods

private extension HomeView {
  func updateLocalData(monthlyTodos: [HomeTodo]) {
    let id = store.currentDate.date.format(.monthlyId)
    if let todoIdx = monthlyTodosList.firstIndex(where: { $0.id == id }) {
      if monthlyTodos.isEmpty {
        modelContext.delete(monthlyTodosList[todoIdx])
      } else {
        monthlyTodosList[todoIdx].todos = monthlyTodos
      }
    } else if !monthlyTodos.isEmpty {
      modelContext.insert(MonthlyTodos(id: id, todos: monthlyTodos))
    }
  }

  func updateLocalData(dailyTodos: [HomeTodo]) {
    let id = store.currentDate.date.format(.dailyId)
    if let todoIdx = dailyTodosList.firstIndex(where: { $0.id == id }) {
      if dailyTodos.isEmpty {
        modelContext.delete(dailyTodosList[todoIdx])
      } else {
        dailyTodosList[todoIdx].todos = dailyTodos
      }
    } else if !dailyTodos.isEmpty {
      modelContext.insert(DailyTodos(id: id, todos: dailyTodos))
    }
  }

  func delayTodo(todo: HomeTodo, date: Date) {
    switch todo.category {
    case .monthly:
      let id = date.format(.monthlyId)
      if let todoIdx = monthlyTodosList.firstIndex(where: { $0.id == id }) {
        let updatedTodos = monthlyTodosList[todoIdx].todos
        monthlyTodosList[todoIdx].todos = updatedTodos.updating(todo: todo)
      } else {
        let updatedTodo = HomeTodo(content: todo.content, isDone: todo.isDone, category: todo.category)
        modelContext.insert(MonthlyTodos(id: id, todos: [updatedTodo]))
      }

    case .daily:
      let id = date.format(.dailyId)
      if let todoIdx = dailyTodosList.firstIndex(where: { $0.id == id }) {
        let updatedTodos = dailyTodosList[todoIdx].todos
        dailyTodosList[todoIdx].todos = updatedTodos.updating(todo: todo)
      } else {
        let updatedTodo = HomeTodo(content: todo.content, isDone: todo.isDone, category: todo.category)
        modelContext.insert(DailyTodos(id: id, todos: [updatedTodo]))
      }
    }
  }

  func changeTodos(oldDate: HomeDate, newDate: HomeDate) {
    let oldMonthlyId = oldDate.date.format(.monthlyId)
    let monthlyId = newDate.date.format(.monthlyId)
    let dailyId = newDate.date.format(.dailyId)

    if monthlyId != oldMonthlyId || !store.isInitialMonthlyLoaded {
      let monthlyTodo = monthlyTodosList.first { $0.id == monthlyId }
      send(.monthlyTodosUpdated(monthlyTodo?.todos ?? []))
    }

    let dailyTodo = dailyTodosList.first { $0.id == dailyId }
    send(.dailyTodosUpdated(dailyTodo?.todos ?? []))
  }
}

#Preview {
  HomeView(
    store: .init(initialState: Home.State()) {
      Home()
    }
  )
}
