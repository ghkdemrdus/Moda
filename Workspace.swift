//
//  Workspace.swift
//  Config
//
//  Created by 황득연 on 9/15/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(
    name: Module.organization,
    projects: {
        var projects: [Path] = [.relativeToApp("/Moda")]
        projects += Module.Core.allCases.map {
            .relativeToCore($0.name)
        }
        projects += Module.Shared.allCases.map {
            .relativeToShared($0.name)
        }
        return projects
    }()
)
