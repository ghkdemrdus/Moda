//
//  UIApplication+Extension.swift
//  ModaCore
//
//  Created by 황득연 on 9/29/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import UIKit

public extension UIApplication {
    var keyWindow: UIWindow? {
        UIApplication.shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
    }

    var safeAreaTopHeight: CGFloat {
        keyWindow?.safeAreaInsets.top ?? 0
    }

    var safeAreaBottomHeight: CGFloat {
        keyWindow?.safeAreaInsets.bottom ?? 0
    }
}
