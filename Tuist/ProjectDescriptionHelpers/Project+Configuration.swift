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
        "ASSETCATALOG_COMPILER_APPICON_NAME": "DebugAppIcon",
        "CODE_SIGN_IDENTITY": "iPhone Developer",
        "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
        "PRODUCT_BUNDLE_IDENTIFIER": "com.pinto.moda.debug",
        "ENV_GOOGLE_INFO_PLIST": "GoogleService-Debug-Info",
        "BUNDLE_DISPLAY_NAME": "ModaDebug",
        "CODE_SIGN_STYLE": "Automatic",
    ])

    public static let release = base.merge([
        "CODE_SIGN_IDENTITY": "iPhone Distribution",
        "SWIFT_OPTIMIZATION_LEVEL": "-O",
        "VALIDATE_PRODUCT": "YES",
        "ENV_GOOGLE_INFO_PLIST": "GoogleService-Info",
        "PRODUCT_BUNDLE_IDENTIFIER": "com.pinto.moda",
        "BUNDLE_DISPLAY_NAME": "Moda",
        "CODE_SIGN_STYLE": "Manual",

    ])

    // MARK: - Widget

    public static let debugWidget = base.merge([
        "CODE_SIGN_IDENTITY": "iPhone Developer",
        "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
        "PRODUCT_BUNDLE_IDENTIFIER": "com.pinto.moda.debug.ModaWidget",
        "CODE_SIGN_STYLE": "Automatic",
    ])

    public static let releaseWidget = base.merge([
        "CODE_SIGN_IDENTITY": "iPhone Distribution",
        "SWIFT_OPTIMIZATION_LEVEL": "-O",
        "VALIDATE_PRODUCT": "YES",
        "PRODUCT_BUNDLE_IDENTIFIER": "com.pinto.moda.ModaWidget",
        "CODE_SIGN_STYLE": "Manual",
    ])
}
