//
//  Font+Moda.swift
//  moda
//
//  Created by 황득연 on 2/24/24.
//

import SwiftUI

extension Font {
  enum SpoqaHanSansWeight: String {
    case bold = "Bold"
    case regular = "Regular"
    case light = "Light"
    case medium = "Medium"
    case thin = "Thin"
  }

  static func spoqaHans(size: CGFloat, weight: SpoqaHanSansWeight = .regular) -> Font {
    return Font.custom("SpoqaHanSansNeo-\(weight.rawValue)", size: size)
  }
}
