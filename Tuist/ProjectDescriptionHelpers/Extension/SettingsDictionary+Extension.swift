//
//  Project+SettingsDictionary.swift
//  ProjectDescriptionHelpers
//
//  Created by Luke Hwang on 2/20/24.
//

import ProjectDescription

public extension SettingsDictionary {
    func merge(_ others: Self...) -> Self {
        var result: [String: SettingValue] = [:]
        result.merge(self, uniquingKeysWith: { $1 })
        others.forEach { other in
            result.merge(other, uniquingKeysWith: { $1 })
        }
        return result
    }

    static func + (left: SettingsDictionary, right: SettingsDictionary) -> SettingsDictionary {
        return left.merge(right)
    }
}
