//
//  UIViewController+Preview.swift
//  moda
//
//  Created by 황득연 on 2022/10/05.
//

#if canImport(SwiftUI) && DEBUG
enum DeviceType {
    case iPhone13Pro
    case iPhone14Pro

    func name() -> String {
        switch self {
        case .iPhone13Pro:
            return "iPhone 13 Pro"
        case .iPhone14Pro:
            return "iPhone 14 Pro"
        }
    }
}

import SwiftUI
extension UIViewController {

    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func showPreview(_ deviceType: DeviceType = .iPhone13Pro) -> some View {
        Preview(viewController: self).previewDevice(PreviewDevice(rawValue: deviceType.name()))
    }
}
#endif
