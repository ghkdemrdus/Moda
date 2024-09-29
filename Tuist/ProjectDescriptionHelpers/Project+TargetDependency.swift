//
//  Project+TargetDependency.swift
//  ProjectDescriptionHelpers
//
//  Created by Luke Hwang on 2/8/24.
//

import ProjectDescription

public extension TargetDependency {
    private static func project(layer: String, module: String, target: String) -> TargetDependency {
        .project(target: target, path: .relativeToRoot("\(layer)/\(module)"))
    }

    static func app(implementation app: Module.App) -> TargetDependency {
        .project(layer: Module.App.layer, module: app.name, target: app.name)
    }

    static func app(interface app: Module.App) -> TargetDependency {
        .project(layer: Module.App.layer, module: app.name + "/Interface", target: app.name + "Interface")
    }

    static func app(ui app: Module.App) -> TargetDependency {
        .project(layer: Module.App.layer, module: app.name + "/UI", target: app.name + "UI")
    }

    static func appExtension(implementation appExtension: Module.App.Extension) -> TargetDependency {
        .target(name: "\(appExtension.name)Extension")
    }

    static func shared(implementation shared: Module.Shared) -> TargetDependency {
        .project(layer: Module.Shared.layer, module: shared.name, target: shared.name)
    }

    static func shared(interface shared: Module.Shared) -> TargetDependency {
        .project(layer: Module.Shared.layer, module: shared.name + "Interface", target: shared.name)
    }

    static func core(implementation core: Module.Core) -> TargetDependency {
        .project(layer: Module.Core.layer, module: core.name, target: core.name)
    }

    static func core(interface core: Module.Core) -> TargetDependency {
        .project(layer: Module.Core.layer, module: core.name + "Interface", target: core.name)
    }

    static func thirdParty(_ framework: Module.ThirdParty) -> TargetDependency {
        .external(name: framework.name)
    }
}
