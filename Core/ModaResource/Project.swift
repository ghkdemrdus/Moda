import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: Module.Core.resource.name,
    organizationName: Module.organization,
    options: .options(
        textSettings: .textSettings(usesTabs: false, indentWidth: 2, tabWidth: 2, wrapsLines: true)
    ),
    targets: [
        .core(implementation: .resource)
    ]
)
