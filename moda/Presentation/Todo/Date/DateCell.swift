//
//  DateCell.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import UIKit
import Then

class DateCell: UICollectionViewCell {
  
  private var bg: UIColor = .white
  
  // MARK: - UI
  
  private let dayView = UIView().then {
    $0.layer.cornerRadius = 6
  }
    
  private let weekdayLabel = UILabel().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .custom(.bold, 13)
  }
  private let dayLabel = UILabel().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .custom(.bold, 13)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
}

extension DateCell {
  
  private func configureUI() {
    self.contentView.addSubview(self.dayView)
    self.dayView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.bottom.equalToSuperview()
      $0.width.equalTo(40)
    }
    self.dayView.addSubview(self.weekdayLabel)
    self.weekdayLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.centerX.equalToSuperview()
    }
    
    self.dayView.addSubview(self.dayLabel)
    self.dayLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(self.weekdayLabel.snp.bottom).offset(10)
    }
  }
}

extension DateCell {
  func configure(with date: DateItem?) {
    if let date = date {
      self.dayView.backgroundColor = date.isSelected ? .dateBg : .white
      self.dayLabel.text = String(date.date.getDay())
      self.dayLabel.textColor = date.isSelected ? .currentDate : date.isPrevious ? .previousDate : .followingDate
      self.weekdayLabel.text = date.date.getWeedDay()
      self.weekdayLabel.textColor = date.isSelected ? .currentDate : date.isPrevious ? .previousDate : .followingDate
    }
    //        self.dayLabel.flex.markDirty()
    //        self.dayOfWeekLabel.flex.markDirty()
  }
}
