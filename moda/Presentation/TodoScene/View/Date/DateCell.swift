//
//  DateCell.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import UIKit
import Then

class DateCell: UICollectionViewCell {
    
  // MARK: - UI
  
  private let dateView = UIView().then {
    $0.layer.cornerRadius = 6
  }
  private let dayView = UIView().then {
    $0.layer.cornerRadius = 16
  }
  private let weekdayLabel = UILabel().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .spoqaHanSansNeo(type: .bold, size: 13)
  }
  private let dayLabel = UILabel().then {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .spoqaHanSansNeo(type: .bold, size: 13)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func prepareForReuse() {
    self.dateView.backgroundColor = nil
    self.dayView.backgroundColor = nil
    self.dayView.layer.borderWidth = 0
  }
  
}

extension DateCell {
  
  private func configureUI() {
    self.contentView.addSubview(self.dateView)
    self.dateView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.bottom.equalToSuperview()
      $0.width.equalTo(40)
    }
    self.dateView.addSubview(self.weekdayLabel)
    self.weekdayLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.centerX.equalToSuperview()
    }
    
    self.dateView.addSubview(self.dayView)
    self.dayView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(self.weekdayLabel.snp.bottom).offset(4)
      $0.width.equalTo(32)
      $0.height.equalTo(32)
    }
    
    self.dayView.addSubview(dayLabel)
    self.dayLabel.snp.makeConstraints {
      $0.centerY.centerX.equalToSuperview()
    }
  }
}

extension DateCell {
  func configure(with date: DateItem?) {
    if let date = date {
      self.dateView.backgroundColor = date.isCurrent ? .dateBg : .white
      self.dayLabel.text = String(date.date.toDayFormat())
      self.dayLabel.textColor = date.isCurrent ? .currentDate : date.isPrevious ? .previousDate : .followingDate
      self.weekdayLabel.text = date.date.toWeedDayFormat()
      self.weekdayLabel.textColor = date.isCurrent ? .currentDate : date.isPrevious ? .previousDate : .followingDate
      self.updateDayViewBackground(date: date)
    }
  }
  
  func updateDayViewBackground(date: DateItem) {
    if date.isCurrent == true {
      self.dayView.backgroundColor = .dateBg
      return
    }
    if date.isSelected == true {
      if date.isPrevious == true {
        self.dayView.layer.borderWidth = 1
        self.dayView.layer.borderColor = UIColor.dateBg.cgColor
      } else {
        self.dayView.backgroundColor = .followingDayBg
      }
    }
      
  }
}
