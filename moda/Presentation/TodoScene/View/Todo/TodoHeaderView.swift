//
//  TodoHeaderView.swift
//  moda
//
//  Created by 황득연 on 2022/11/12.
//

import UIKit
import SnapKit
import Then

final class TodoHeaderView: UICollectionReusableView {
  
  private let titleLabel = UILabel().then {
    $0.textColor = .todoTitle
    $0.font = .spoqaHanSansNeo(type: .bold, size: 19)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureUI()
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func configureUI() {
    self.addSubview(self.titleLabel)
    self.titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(12)
      $0.left.equalToSuperview()
    }
  }
  
  func updateUI(title: String) {
    self.titleLabel.text = title
  }
}

