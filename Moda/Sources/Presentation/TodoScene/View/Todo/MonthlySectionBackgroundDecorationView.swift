//
//  MonthlySEctionBackgroundDecorationView.swift
//  moda
//
//  Created by 황득연 on 2022/11/12.
//

import UIKit
import SnapKit

class MonthlySectionBackgroundDecorationView: UICollectionReusableView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .monthlyBg
    self.layer.cornerRadius = 7
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
