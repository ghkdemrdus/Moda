//
//  ContentSizePreferenceKey.swift
//  ModaCore
//
//  Created by 황득연 on 9/29/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

private struct ContentSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

public extension View {
    func onChangeSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: ContentSizePreferenceKey.self, value: proxy.size)
            }
        )
        .onPreferenceChange(ContentSizePreferenceKey.self, perform: onChange)
    }
}
