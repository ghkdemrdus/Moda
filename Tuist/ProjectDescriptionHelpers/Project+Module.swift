//
//  Project+Module.swift
//  ProjectDescriptionHelpers
//
//  Created by Luke Hwang on 2/8/24.
//

import ProjectDescription

public enum Module {

    public static let organization = "Moda"

    // MARK: - App

    public enum App: String {
        public enum Extension: String, CaseIterable {
            case widget = "ModaWidget"

            public var name: String { self.rawValue }
        }
        
        case moda = "Moda"

        public static let layer = "App"
        public var name: String { self.rawValue }
        public var settings: ProjectDescription.Settings {
            switch self {
            case .moda:
                return .defaultTarget
            }
        }
    }

    // MARK: - Core

    public enum Core: String, CaseIterable {
        case core = "ModaCore"
        case data = "ModaData"
        case resource = "ModaResource"

        public static let layer = "Core"
        public var name: String { self.rawValue }
        public var hasResources: Bool {
            switch self {
            case .resource: return true
            default: return false
            }
        }
    }

    // MARK: - Shared

    public enum Shared: String, CaseIterable {
        case utility = "ModaFoundation"

        public static let layer = "Shared"
        public var name: String { self.rawValue }
    }

    // MARK: Third Party Framework

    public enum ThirdParty: String, CaseIterable {
        case composableArchitecture = "ComposableArchitecture"
        case kingfisher = "Kingfisher"
        case realm = "RealmSwift"

        // MARK: - Properties

        public var name: String { self.rawValue }
        public var framework: Product {
            switch self {
            case .kingfisher, .realm, .composableArchitecture:
                return .framework
            }
        }
    }
}
