import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: Module.Core.data.name,
    organizationName: Module.organization,
    options: .options(
        automaticSchemesOptions: .disabled,
        textSettings: .textSettings(usesTabs: false, indentWidth: 2, tabWidth: 2, wrapsLines: true)
    ),
    settings: .defaultProject,
    targets: [
        .core(
            implementation: .data,
            dependencies: [
                .core(implementation: .core),
                .thirdParty(.realm),
            ]
        )
    ]
)
