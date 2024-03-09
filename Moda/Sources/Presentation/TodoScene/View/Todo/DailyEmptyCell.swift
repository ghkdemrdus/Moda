//
//  DailyEmptyCell.swift
//  moda
//
//  Created by 황득연 on 2022/11/13.
//

import UIKit
import RxSwift
import SnapKit
import Then

final class DailyEmptyCell: UICollectionViewCell {
  
  private let fightingImageView = UIImageView().then {
    $0.image = .dailyEmpty
    $0.contentMode = .scaleAspectFit
  }
  
  private let contentLabel = UILabel().then {
    $0.textAlignment = .center
    $0.text = "오늘의 할 일을 가벼운 마음으로\n적어볼까요?"
    $0.textColor = .dailyEmpty
    $0.numberOfLines = 2
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
    self.contentView.addSubview(self.fightingImageView)
    self.fightingImageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(54)
      $0.width.equalTo(158)
      $0.height.equalTo(123)
    }
    
    self.contentView.addSubview(self.contentLabel)
    self.contentLabel.snp.makeConstraints {
      $0.top.equalTo(self.fightingImageView.snp.bottom).offset(25)
      $0.left.right.equalToSuperview()
    }
  }
}
