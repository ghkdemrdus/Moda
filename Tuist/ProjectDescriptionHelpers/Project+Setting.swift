//
//  Project+Setting.swift
//  ProjectDescriptionHelpers
//
//  Created by Luke Hwang on 2/20/24.
//

import ProjectDescription

// MARK: - Project Settings

public extension Settings {
    static let defaultProject: Settings = .settings(
        configurations: [
            .debug(name: .debug, settings: debugProject),
            .release(name: .release, settings: releaseProject)
        ]
    )

    private static let baseProject: SettingsDictionary = [
        "DEVELOPMENT_TEAM": "79K7D639YK"
    ]

    private static let debugProject: SettingsDictionary = baseProject.merge([
        "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym",
        "ENABLE_NS_ASSERTIONS": "NO",
        "ENABLE_TESTABILITY": "YES",
        "GCC_DYNAMIC_NO_PIC": "NO",
        "GCC_OPTIMIZATION_LEVEL": "0",
        "GCC_PREPROCESSOR_DEFINITIONS": "$(inherited) DEBUG=1",
        "MTL_ENABLE_DEBUG_INFO": "INCLUDE_SOURCE",
        "ONLY_ACTIVE_ARCH": "YES",
        "SWIFT_ACTIVE_COMPILATION_CONDITIONS": "DEBUG",
        "SWIFT_OPTIMIZATION_LEVEL": "-Onone"
    ])

    private static let releaseProject: SettingsDictionary = baseProject.merge([
        "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym",
        "ENABLE_NS_ASSERTIONS": "NO",
        "MTL_ENABLE_DEBUG_INFO": "NO",
        "SWIFT_COMPILATION_MODE": "wholemodule",
        "SWIFT_OPTIMIZATION_LEVEL": "-O"
    ])
}

// MARK: - Target Settings

public extension Settings {
    static let defaultTarget: ProjectDescription.Settings =
        .settings(
            configurations: [
                .debug(name: .debug, settings: ConfigurationSetting.debug),
                .release(name: .release, settings: ConfigurationSetting.release)
            ]
        )

    static let packageTarget: ProjectDescription.Settings =
        .settings(
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ]
        )
}
