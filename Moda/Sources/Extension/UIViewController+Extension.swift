//
//  UIViewController+Extension.swift
//  moda
//
//  Created by 황득연 on 2022/10/11.
//

import UIKit

extension UIViewController {
  func createButton(name: String) -> UIButton {
    let button = UIButton().then {
      $0.setImage(UIImage(systemName: name), for: .normal)
      $0.contentMode = .scaleAspectFill
    }
    return button
  }
}
