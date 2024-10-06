//
//  UIScreen+Extension.swift
//  ModaCore
//
//  Created by 황득연 on 9/29/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import UIKit

public extension UIScreen {
  static var size: CGSize {
    return UIScreen.main.bounds.size
  }

  static var width: CGFloat {
    return UIScreen.main.bounds.width
  }

  static var height: CGFloat {
    return UIScreen.main.bounds.height
  }

  static var heightExceptSafeArea: CGFloat {
    UIScreen.height
    - (UIApplication.shared.safeAreaTopHeight)
    - (UIApplication.shared.safeAreaBottomHeight)
  }
}
