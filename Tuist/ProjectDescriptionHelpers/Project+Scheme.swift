//
//  Project+Scheme.swift
//  ProjectDescriptionHelpers
//
//  Created by 황득연 on 9/17/24.
//

import ProjectDescription

public extension Scheme {
    static let `default`: [Scheme] = [
        debug, release
    ]

    static let debug = Scheme.scheme(
        name: "ModaDebug",
        shared: true,
        buildAction: .buildAction(targets: ["Moda"]),
        runAction: .runAction(
            configuration: .debug,
            executable: "Moda"
        )
    )

    static let release = Scheme.scheme(
        name: "Moda",
        shared: true,
        buildAction: .buildAction(targets: ["Moda"]),
        runAction: .runAction(
            configuration: .release,
            executable: "Moda"
        )
    )
}
