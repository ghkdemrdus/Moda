//
//  GradientModifier.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 10/5/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

struct GradientModifier: ViewModifier {
    private let edges: [Edge]
    private let color: Color
    private let length: CGFloat

    init(
        edges: [Edge] = [.top, .bottom],
        color: Color,
        length: CGFloat = 10
    ) {
        self.edges = edges
        self.color = color
        self.length = length
    }

    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    VStack {
                        if edges.contains(where: { $0 == .top }) {
                            LinearGradient(
                                gradient: Gradient(colors: [color, .clear]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: length)
                        }

                        Spacer()

                        if edges.contains(where: { $0 == .bottom }) {
                            LinearGradient(
                                gradient: Gradient(colors: [color, .clear]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                            .frame(height: length)
                        }
                    }

                    HStack {
                        if edges.contains(where: { $0 == .leading }) {
                            LinearGradient(
                                gradient: Gradient(colors: [color, .clear]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(width: length)
                        }

                        Spacer()

                        if edges.contains(where: { $0 == .trailing }) {
                            LinearGradient(
                                gradient: Gradient(colors: [color, .clear]),
                                startPoint: .trailing,
                                endPoint: .leading
                            )
                            .frame(width: length)
                        }
                    }
                }
                .allowsHitTesting(false)
            )
    }
}

public extension View {
    func gradient(
        _ edges: [Edge] = [.top, .bottom],
        color: Color = .black.opacity(0.05),
        length: CGFloat = 10
    ) -> some View {
        modifier(
            GradientModifier(
                edges: edges,
                color: color,
                length: length
            )
        )
    }
}
