//
//  BookmarkView.swift
//  Moda
//
//  Created by 황득연 on 10/15/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: BookmarkCore.self)

struct BookmarkView: View {

  @Bindable var store: StoreOf<BookmarkCore>

  var body: some View {
    content
  }
}

// MARK: - Content

private extension BookmarkView {
  var content: some View {
    VStack {
      Text("Bookmark")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.blue)
  }
}
