//
//  Project+Path.swift
//  ResourceSynthesizers
//
//  Created by Luke Hwang on 1/19/24.
//

import ProjectDescription

public extension Path {
    static func relativeToApp(_ path: String) -> Path {
        return .relativeToRoot("\(Module.App.layer)/\(path)")
    }
    static func relativeToCore(_ path: String) -> Path {
        return .relativeToRoot("\(Module.Core.layer)/\(path)")
    }
    static func relativeToShared(_ path: String) -> Path {
        return .relativeToRoot("\(Module.Shared.layer)/\(path)")
    }
}
