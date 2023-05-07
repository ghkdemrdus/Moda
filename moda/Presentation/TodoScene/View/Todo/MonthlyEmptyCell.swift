//
//  MonthlyEmptyCell.swift
//  moda
//
//  Created by 황득연 on 2022/11/13.
//


import UIKit
import RxSwift
import SnapKit
import Then
//54
final class MonthlyEmptyCell: UICollectionViewCell {
  
  private let contentLabel = UILabel().then {
    $0.textAlignment = .center
    $0.text = "이번 달에 할 일들을 가볍게 적어봐요!"
    $0.textColor = .monthlyEmpty
    $0.font = .spoqaHanSansNeo(type: .medium, size: 15)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func configureUI() {
    self.contentView.addSubview(self.contentLabel)
    self.contentLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(8)
      $0.bottom.equalToSuperview().offset(-10)
      $0.left.right.equalToSuperview()
    }
  }
}
