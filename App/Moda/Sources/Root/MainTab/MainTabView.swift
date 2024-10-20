//
//  MainTabView.swift
//  Moda
//
//  Created by 황득연 on 10/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

@ViewAction(for: MainTabCore.self)
struct MainTabView: View {
  @Bindable var store: StoreOf<MainTabCore>

  @State var blurRadius: CGFloat = 0

  var body: some View {
    content
      .onChange(of: store.bookmark.isEditPresented) {
        blurRadius = $1 ? 1.2 : 0
      }
      .ignoresSafeArea(.keyboard)
  }
}

// MARK: - Content

private extension MainTabView {
  var content: some View {
    VStack(spacing: 0) {
      TabView(selection: $store.selectedTab) {
          switch store.selectedTab {
          case .bookmark:
            BookmarkView(store: store.scope(state: \.bookmark, action: \.bookmark))
                .tag(MainTab.bookmark)

          case .home:
            HomeView(store: store.scope(state: \.home, action: \.home))
              .tag(MainTab.home)

          case .setting:
            SettingView(store: store.scope(state: \.setting, action: \.setting))
                .tag(MainTab.setting)
          }
      }
      .tabViewStyle(.page(indexDisplayMode: .never))

      HStack {
        ForEach(MainTab.allCases, id: \.self) { tab in
          VStack {
            tab.image
          }
          .frame(maxWidth: .infinity)
          .contentShape(Rectangle())
          .onTapGesture {
            send(.binding(.set(\.selectedTab, tab)))
          }
        }
      }
      .padding(.horizontal, 32)
      .frame(height: 50)
      .blur(radius: blurRadius)
      .overlay(alignment: .top) {
        Color.borderPrimary.frame(height: 1)
      }
    }
  }
}
