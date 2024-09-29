//
//  SplashView.swift
//  ModaData
//
//  Created by 황득연 on 3/18/24.
//

import SwiftUI
import ComposableArchitecture

struct SplashView: View {

  @Bindable var store: StoreOf<Splash>

  public init(store: StoreOf<Splash>) {
    self.store = store
  }

  var body: some View {
    Image.imgSplash
      .ignoresSafeArea()
      .task {
        try? await Task.sleep(for: .seconds(2))
        _ = withAnimation(.easeInOut) {
          store.send(.timeout)
        }
      }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  SplashView(
    store: Store(initialState: Splash.State()) {
      Splash()
    }
  )
}
