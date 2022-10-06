//
//  DateCell.swift
//  moda
//
//  Created by 황득연 on 2022/10/04.
//

import FlexLayout
import PinLayout
import UIKit

class DateCell: UICollectionViewCell {
  
  private var bg: UIColor = .white
  
  // MARK: - UI
  private let container = UIView()
  private let weekdayLabel = UILabel()
  private let dayLabel = UILabel()
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.contentView.flex.layout()
  }
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return self.contentView.frame.size
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setupView()
    self.defineLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
}

extension DateCell {
  private func setupView() {
    self.weekdayLabel.font = UIFont.Custom(.bold, 13)
    self.dayLabel.font = UIFont.Custom(.bold, 13)
  }
  
  private func defineLayout() {
    self.contentView.flex
      .direction(.column)
      .define {
        $0.addItem(self.container)
          .alignItems(.center)
          .marginHorizontal(6)
          .backgroundColor(bg)
          .define {
            $0.view?.setCornerRadius(6)
            $0.addItem(self.dayLabel)
              .marginTop(10)
            $0.addItem(self.weekdayLabel)
              .marginTop(12)
gt              .width(20)
              .justifyContent(.center)
          }
      }
  }
}

extension DateCell {
  func configure(_ date: DateItem) {
    self.dayLabel.text = date.date.getWeedDay()
    self.weekdayLabel.text = String(date.date.getDay())
    print("hihihi \(String(date.date.getDay()))")
    self.container.backgroundColor = date.isSelected ? .dateBg : .white
    self.dayLabel.textColor = date.isSelected ? .currentDate : date.isPrevious ? .previousDate : .followingDate
    self.weekdayLabel.textColor = date.isSelected ? .currentDate : date.isPrevious ? .previousDate : .followingDate
    
    //        self.dayLabel.flex.markDirty()
    //        self.dayOfWeekLabel.flex.markDirty()
  }
}
