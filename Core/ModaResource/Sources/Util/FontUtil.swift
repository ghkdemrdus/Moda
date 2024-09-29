//
//  FontUtil.swift
//  ModaResource
//
//  Created by 황득연 on 9/21/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import SwiftUI

public struct FontUtil {
  public static func registerCustomFonts() {
    let fonts = [
      "SpoqaHanSansNeo-Bold.otf",
      "SpoqaHanSansNeo-Light.otf",
      "SpoqaHanSansNeo-Medium.otf",
      "SpoqaHanSansNeo-Regular.otf",
      "SpoqaHanSansNeo-Thin.otf"
    ]
    for font in fonts {
      guard let url = Bundle.module.url(forResource: font, withExtension: nil) else { return }
      CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }
  }
}

public extension View {
  func loadCustomFonts() -> some View {
    FontUtil.registerCustomFonts()
    return self
  }
}
