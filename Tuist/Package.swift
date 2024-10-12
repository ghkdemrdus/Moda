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
            dicts["_LottieStub"] = .framework
            return dicts
        }(),
        baseSettings: .packageTarget
    )

#endif

// MARK: - ThirdParty Package

enum ThirdPartyPackage: CaseIterable {
    case composableArchitecture
    case firebase
    case lottie
    case realm

    var remoteURL: String {
        switch self {
        case .composableArchitecture: "https://github.com/pointfreeco/swift-composable-architecture"
        case .firebase: "https://github.com/firebase/firebase-ios-sdk.git"
        case .lottie: "https://github.com/airbnb/lottie-spm.git"
        case .realm: "https://github.com/realm/realm-swift"
        }
    }

    var version: Range<PackageDescription.Version> {
        switch self {
        case .composableArchitecture: .upToNextMajor(from: "1.15.0")
        case .firebase: .upToNextMajor(from: "11.3.0")
        case .lottie: .upToNextMajor(from: "4.4.3")
        case .realm: .upToNextMajor(from: "20.0.0")
        }
    }
}

// MARK: - Package

let package = Package(
    name: "ThirdParty",
    dependencies: ThirdPartyPackage.allCases.map { .package(url: $0.remoteURL, $0.version) }
)

