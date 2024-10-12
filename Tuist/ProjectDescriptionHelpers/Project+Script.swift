//
//  Project+Script.swift
//  ProjectDescriptionHelpers
//
//  Created by 황득연 on 10/12/24.
//

import ProjectDescription

public extension TargetScript {
    static let googleService: TargetScript = .pre(
        script: "GOOGLE_SERVICE_INFO_PLIST_FROM=\"${PROJECT_DIR}/Resources/${ENV_GOOGLE_INFO_PLIST}.plist\"\nBUILD_APP_DIR=\"${BUILT_PRODUCTS_DIR}/${FULL_PRODUCT_NAME}\"\nGOOGLE_SERVICE_INFO_PLIST_TO=\"${BUILD_APP_DIR}/GoogleService-Info.plist\"\ncp \"${GOOGLE_SERVICE_INFO_PLIST_FROM}\" \"${GOOGLE_SERVICE_INFO_PLIST_TO}\"",
        name: "Google Service"
    )

    static let firebaseCrashlytics: TargetScript = .post(
        // Tuist에서 SPM을 빌드하므로 디렉토리를 맞게 수정하였음
        script: "\"${PROJECT_DIR}/../../Tuist/.build/checkouts/firebase-ios-sdk/Crashlytics/run\"",
        name: "Firebase Crashlytics",
        inputPaths: [
            "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}",
            "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${PRODUCT_NAME}",
            "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plist",
            "$(TARGET_BUILD_DIR)/$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/GoogleService-Info.plist",
            "$(TARGET_BUILD_DIR)/$(EXECUTABLE_PATH)"
        ]
    )
}
