//
//  Widget+Extension.swift
//  ModaWidgetExtension
//
//  Created by 황득연 on 3/9/24.
//

import SwiftUI

extension Widget {
  
  // 해당 HIG를 기반하여 위젯 사이즈를 불러온다.
  // https://developer.apple.com/design/human-interface-guidelines/widgets#iOS-widget-dimensions
  static var mediumSize: CGSize {
    let screenBounds = UIScreen.main.bounds.size
    let height = screenBounds.height
    let width = screenBounds.width
    switch (width, height) {
    case (430, 932), (428, 926):
      return .init(width: 364, height: 170)
      
    case (414, 896):
      return .init(width: 360, height: 169)
      
    case (414, 736):
      return .init(width: 348, height: 157)
      
    case (393, 852), (390, 844):
      return .init(width: 338, height: 158)
      
    case (375, 812), (360, 780):
      return .init(width: 329, height: 155)
      
    case (375, 667):
      return .init(width: 321, height: 148)
      
    case (320, 568):
      return .init(width: 292, height: 141)
      
    default:
      return .init(width: 329, height: 155)
    }
  }
}
