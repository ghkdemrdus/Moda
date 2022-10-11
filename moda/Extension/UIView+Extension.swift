//
//  UIView+Extension.swift
//  moda
//
//  Created by 황득연 on 2022/10/05.
//

import UIKit
import Then

extension UIView {
  func setCornerRadius(_ radius: CGFloat? = nil) {
    if let radius = radius {
      self.layer.cornerRadius = radius
    } else {
      self.layer.cornerRadius = self.frame.height / 2
    }
    self.layer.masksToBounds = true
    self.layer.cornerCurve = .continuous
  }
  
  
}
