//
//  Project+Configuration.swift
//  ProjectDescriptionHelpers
//
//  Created by 황득연 on 9/17/24.
//

import ProjectDescription

public enum ConfigurationSetting {

    // MARK: - Common

    public static let base: SettingsDictionary = [
        "CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED": "YES",
        "CLANG_ENABLE_OBJC_WEAK": "YES",
    ]

    public static let debug = base.merge([
        "CODE_SIGN_IDENTITY": "iPhone Developer",
        "CODE_SIGN_STYLE": "Automatic",
        "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
        "PRODUCT_BUNDLE_IDENTIFIER": "com.pinto.moda.debug",
        "BUNDLE_DISPLAY_NAME": "ModaDebug"
    ])

    public static let release = base.merge([
        "CODE_SIGN_IDENTITY": "iPhone Distribution",
        "CODE_SIGN_STYLE": "Manual",
        "SWIFT_OPTIMIZATION_LEVEL": "-O",
        "VALIDATE_PRODUCT": "YES",
        "PRODUCT_BUNDLE_IDENTIFIER": "com.pinto.moda",
        "BUNDLE_DISPLAY_NAME": "Moda"
    ])
}
