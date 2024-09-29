//
//  Font+Extension.swift
//  moda
//
//  Created by 황득연 on 3/22/24.
//

import SwiftUI

public extension Font {
  enum FontWeight: String {
    case bold = "Bold"
    case regular = "Regular"
    case light = "Light"
    case medium = "Medium"
    case thin = "Thin"
  }

  static func spoqaHans(size: CGFloat, weight: FontWeight = .medium) -> Font {
    return Font.custom("SpoqaHanSansNeo-\(weight.rawValue)", size: size)
  }
}
