//
//  FontUtil.swift
//  ModaResource
//
//  Created by 황득연 on 10/12/24.
//  Copyright © 2024 Moda. All rights reserved.
//

import UIKit
import SwiftUI

public struct FontUtil {
    public static func registerCustomFonts() {
        let fonts = [
            "SpoqaHanSansNeo-Bold.otf",
            "SpoqaHanSansNeo-Medium.otf",
            "SpoqaHanSansNeo-Regular.otf"
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
