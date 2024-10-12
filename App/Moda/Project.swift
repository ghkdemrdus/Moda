import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: Module.App.moda.name,
    organizationName: Module.organization,
    options: .options(
        textSettings: .textSettings(usesTabs: false, indentWidth: 2, tabWidth: 2, wrapsLines: true)
    ),
    settings: .defaultProject,
    targets: [
        .app(
            implementation: .moda,
            scripts: [
                .firebaseCrashlytics,
                .googleService
            ],
            dependencies: [
                .appExtension(implementation: .widget),
                .core(implementation: .core),
                .core(implementation: .data),
                .core(implementation: .resource),
                .thirdParty(.composableArchitecture),
            ]
            + Module.ThirdParty.firebase.map { .thirdParty($0) }
        ),
        .appExtension(
            implementation: .widget,
            dependencies: [
                .core(implementation: .core),
                .core(implementation: .data),
                .core(implementation: .resource),
            ]
        )
    ],
    schemes: Scheme.default,
    resourceSynthesizers: []
)
