import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project(
  name: "Moda",
  options: .options(textSettings: .textSettings(usesTabs: false, indentWidth: 2, tabWidth: 2, wrapsLines: true)),
  packages: [],
  targets: [
    Target(
      name: "moda",
      destinations: .iOS,
      product: .app,
      bundleId: "com.pinto.moda",
      deploymentTargets: .iOS("16.0"),
      infoPlist: "Moda/Info.plist",
      sources: [
        "Moda/Sources/**", "Moda/Config.swift", "ModaWidget/Sources/ModaIntent.swift"
      ],
      resources: ["Moda/Resources/**"],
      entitlements: "Moda/moda.entitlements",
      dependencies: [
        .target(name: "ModaWidgetExtension")
      ],
      settings: .settings(base: [
        "DEVELOPMENT_TEAM": "79K7D639YK",
        "CODE_SIGN_STYLE": "Automatic"
      ])
    ),
    Target(
        name: "ModaWidgetExtension",
        destinations: .iOS,
        product: .appExtension,
        bundleId: "com.pinto.moda.ModaWidget",
        deploymentTargets: .iOS("16.0"),
        infoPlist: "ModaWidget/Info.plist",
        sources: [
            "ModaWidget/Sources/**",
            "Moda/Config.swift",
            "Moda/Sources/Domain/**",
            "Moda/Sources/Data/**",
            "Moda/Sources/Extension/**",
            "Moda/Sources/Util/**"
        ],
        resources: [
            "ModaWidget/Resources/**"
        ],
        entitlements: "ModaWidget/ModaWidgetExtension.entitlements",
        settings: .settings(base: [
          "DEVELOPMENT_TEAM": "79K7D639YK",
          "CODE_SIGN_STYLE": "Automatic"
        ])
    )
  ]
)
