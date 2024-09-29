//
//  HideKeyboardModifiler.swift
//  ModaCore
//
//  Created by 황득연 on 9/21/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct HideKeyboardModifiler: ViewModifier {
    func body(content: Content) -> some View {
        content
            .contentTouchable()
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}

public extension View {
    func hideKeyboardIfTapped() -> some View {
        self.modifier(HideKeyboardModifiler())
    }
}
