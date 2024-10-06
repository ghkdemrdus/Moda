// swift-tools-version: 5.10
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        productTypes: {
            var dicts = Dictionary(
                uniqueKeysWithValues: Module.ThirdParty.allCases.map { ($0.name, $0.framework) }
            )
            return dicts
        }(),
        baseSettings: .packageTarget
    )

#endif

// MARK: - ThirdParty Package

enum ThirdPartyPackage: CaseIterable {
    case composableArchitecture
    case kingfisher
    case realm

    var remoteURL: String {
        switch self {
        case .composableArchitecture: "https://github.com/pointfreeco/swift-composable-architecture"
        case .kingfisher: "https://github.com/onevcat/Kingfisher.git"
        case .realm: "https://github.com/realm/realm-swift"
        }
    }

    var version: Range<PackageDescription.Version> {
        switch self {
        case .composableArchitecture: .upToNextMajor(from: "1.15.0")
        case .kingfisher: .upToNextMajor(from: "7.11.0")
        case .realm: .upToNextMajor(from: "20.0.0")
        }
    }
}

// MARK: - Package

let package = Package(
    name: "ThirdParty",
    dependencies: ThirdPartyPackage.allCases.map { .package(url: $0.remoteURL, $0.version) }
)

