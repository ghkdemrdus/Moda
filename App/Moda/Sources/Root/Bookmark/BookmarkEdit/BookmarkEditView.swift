//
//  BookmarkEditView.swift
//  Moda
//
//  Created by 황득연 on 10/17/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

@ViewAction(for: BookmarkEditCore.self)
struct BookmarkEditView: View {

  @Bindable var store: StoreOf<BookmarkEditCore>

  @State var isInitial: Bool = true

  @FocusState private var focused: Bookmark?

  private let feedback = UIImpactFeedbackGenerator(style: .light)

  var body: some View {
    content
      .onChange(of: store.bookmarks, initial: true) {
        send(.binding(.set(\.updatedBookmarks, $1)))
      }
      .onChange(of: store.updatedBookmarks) {
        defer { isInitial = false}
        if $1.count == 0 {
          let bookmark = Bookmark(title: "")
          send(.binding(.set(\.updatedBookmarks, [bookmark])))
          focused = bookmark
          return
        }

        if $1.count > $0.count, !isInitial {
          focused = $1.last
        }
      }
  }
}

private extension BookmarkEditView {
  @ViewBuilder var content: some View {
    VStack(spacing: 0) {
      Color.clear.frame(height: 40)

      HStack {
        HStack(spacing: 6) {
          Text("북마크")
            .font(.spoqaHans(size: 16, weight: .bold))
            .foregroundStyle(Color.black)

          PlainButton {
            send(.addTapped)
          } label: {
            Image.icBookmarkAdd
          }
        }

        Spacer()

        PlainButton {
          send(.doneTapped(store.updatedBookmarks))
        } label: {
          Text("완료")
            .font(.spoqaHans(size: 14, weight: .bold))
            .foregroundStyle(Color.iconTertiary)
            .frame(height: 40)
        }
      }
      .frame(height: 40)
      .padding(.horizontal, 20)

      DraggableListView(
        items: $store.updatedBookmarks,
        itemHeight: BookmarkEditItemView.height,
        itemView: {
          BookmarkEditItemView(
            bookmark: $0,
            onTapDelete: {
              send(.deleteTapped($0))
            }
          )
          .focused($focused, equals: $0)
        }
      )

      Spacer()
    }
    .background {
      Color.backgroundPrimary.opacity(0.5)
        .ignoresSafeArea()
        .onTapGesture {
          send(.doneTapped(store.updatedBookmarks))
        }
    }
  }
}
