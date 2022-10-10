//
//  UIFont+Extension.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import Foundation
import UIKit

extension UIFont {

    public enum OpenSansType: String {
        case bold = "-Bold"
        case regular = "-Regular"
        case light = "-Light"
        case medium = "-Medium"
        case thin = "-Thin"
    }

    static func custom(_ type: OpenSansType = .regular, _ size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "SpoqaHanSansNeo\(type.rawValue)", size: size)!
    }

    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }

    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }

}
