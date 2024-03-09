//
//  UIView+Extension.swift
//  moda
//
//  Created by 황득연 on 2022/10/05.
//

import UIKit
import Then

extension UIView {
  func setCornerRadius(corners: UIRectCorner, radius: CGFloat) {
       let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
       let mask = CAShapeLayer()
       mask.path = path.cgPath
       layer.mask = mask
   }
}
