//
//  Project+Target.swift
//  ResourceSynthesizers
//
//  Created by Luke Hwang on 1/19/24.
//

import ProjectDescription

public extension Target {
    private static let defaultVersion = "17.0"

    static func makeApp(
        name: String,
        infoPlist: ProjectDescription.InfoPlist?,
        sources: ProjectDescription.SourceFilesList,
        resources: ProjectDescription.ResourceFileElements? = [],
        entitlements: ProjectDescription.Entitlements?,
        scripts: [ProjectDescription.TargetScript] = [],
        dependencies: [ProjectDescription.TargetDependency],
        settings: ProjectDescription.Settings
    ) -> Target {
        .target(
            name: name,
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.pinto.moda",
            deploymentTargets: .iOS(defaultVersion),
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: scripts,
            dependencies: dependencies,
            settings: settings
        )
    }

    static func makeAppExtension(
        name: String,
        infoPlist: ProjectDescription.InfoPlist?,
        sources: ProjectDescription.SourceFilesList,
        resources: ProjectDescription.ResourceFileElements? = [],
        entitlements: ProjectDescription.Entitlements?,
        dependencies: [ProjectDescription.TargetDependency],
        settings: ProjectDescription.Settings? = nil
    ) -> Target {
        .target(
            name: name,
            destinations: [.iPhone],
            product: .appExtension,
            bundleId: "com.pinto.moda.\(name)",
            deploymentTargets: .iOS(defaultVersion),
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            dependencies: dependencies,
            settings: settings
        )
    }

    static func makeFramework(
        name: String,
        infoPlist: ProjectDescription.InfoPlist?,
        sources: ProjectDescription.SourceFilesList,
        resources: ProjectDescription.ResourceFileElements? = [],
        dependencies: [ProjectDescription.TargetDependency] = [],
        settings: ProjectDescription.Settings? = nil
    ) -> Target {
        .target(
            name: name,
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.pinto.moda.\(name)",
            deploymentTargets: .iOS(defaultVersion),
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies,
            settings: settings
        )
    }

    static func app(
        implementation app: Module.App,
        scripts: [ProjectDescription.TargetScript] = [],
        dependencies: [ProjectDescription.TargetDependency] = []
    ) -> Target {
        .makeApp(
            name: app.name,
            infoPlist: .file(path: .relativeToApp("\(app.name)/Info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: .file(path: .relativeToApp("\(app.name)/\(app.name).entitlements")),
            scripts: scripts,
            dependencies: dependencies,
            settings: app.settings
        )
    }

    static func app(interface app: Module.App, dependencies: [ProjectDescription.TargetDependency]) -> Target {
        .makeFramework(
            name: app.name + "Interface",
            infoPlist: .file(path: .relativeToApp("\(app.name)/Interface/Info.plist")),
            sources: ["Sources/**"],
            dependencies: dependencies
        )
    }

    static func app(ui app: Module.App, dependencies: [ProjectDescription.TargetDependency]) -> Target {
        .makeFramework(
            name: app.name + "UI",
            infoPlist: .file(path: .relativeToApp("\(app.name)/UI/Info.plist")),
            sources: ["Sources/**"],
            dependencies: dependencies
        )
    }

    static func appExtension(
        implementation appExtension: Module.App.Extension,
        dependencies: [ProjectDescription.TargetDependency] = [],
        resources: ProjectDescription.ResourceFileElements? = []
    ) -> Target {
        .makeAppExtension(
            name: "\(appExtension.name)Extension",
            infoPlist: .file(path: .relativeToApp("\(appExtension.name)/Info.plist")),
            sources: ["\(appExtension.name)/Sources/**"],
            resources: resources,
            entitlements: .file(path: .relativeToApp("\(appExtension.name)/\(appExtension.name).entitlements")),
            dependencies: dependencies
        )
    }

    static func core(
        implementation core: Module.Core,
        dependencies: [ProjectDescription.TargetDependency] = []
    ) -> Target {
        .makeFramework(
            name: core.name,
            infoPlist: .file(path: .relativeToCore("\(core.name)/Info.plist")),
            sources: ["Sources/**"],
            resources: core.hasResources ? ["Resources/**"] : [],
            dependencies: dependencies
        )
    }

    static func shared(
        implementation shared: Module.Shared,
        dependencies: [ProjectDescription.TargetDependency] = []
    ) -> Target {
        .makeFramework(
            name: shared.name,
            infoPlist: .file(path: .relativeToShared("\(shared.name)/Info.plist")),
            sources: ["Sources/**"],
            dependencies: dependencies
        )
    }
}
